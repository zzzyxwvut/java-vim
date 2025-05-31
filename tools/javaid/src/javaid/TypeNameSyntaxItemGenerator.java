package javaid;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.Writer;
import java.lang.reflect.Modifier;
import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.StringJoiner;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.function.BiConsumer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * A command-line driven generator of optional syntax items for {@code public}
 * and {@code protected} types.
 * <p>
 * As documented in {@code :help java.vim}, the names of {@code public} (and
 * potentially {@code protected}) type members of the {@link java.lang}
 * package may be highlighted when the {@code g:java_highlight_java_lang_ids}
 * variable is defined.  This class provides support for generating similar
 * syntax items for arbitrary types.
 *
 * @see <a href=https://web.archive.org/web/20160608001721/http://www.fleiner.com/vim/Highlight.java><code>Highlight</code></a>,
 *	a version of the original generator
 * @since 11 (JDK)
 */
final class TypeNameSyntaxItemGenerator
{
	private TypeNameSyntaxItemGenerator() { }

	private static String asString(String delimiter,
						Iterator<String> wordIterator)
	{
		final StringJoiner joiner = new StringJoiner(delimiter);

		while (wordIterator.hasNext())
			joiner.add(wordIterator.next());

		return joiner.toString();
	}

	private static String asGrownPrefixString(
			BiConsumer<StringBuilder, StringBuilder> prefixer,
							String delimiter,
							String head,
							String... parts)
	{
		if (parts.length < 1)
			return "";

		final StringBuilder exprBuilder = new StringBuilder(
							64 * parts.length);
		final StringBuilder nameBuilder = new StringBuilder(128);
		nameBuilder.append(head);

		for (String part : parts)
			prefixer.accept(
				exprBuilder,
				nameBuilder.append(delimiter).append(part));

		return exprBuilder.toString();
	}

	private static String asRunOnTitleString(
					Map<String, String> titleNames,
					String name,
					String[] nameParts)
	{
		if (name.isEmpty() || nameParts.length < 1)
			return "";

		final String knownTitleName = titleNames.get(name);

		if (knownTitleName != null)
			return knownTitleName;

		final StringBuilder titleBuilder = new StringBuilder(
						16 * nameParts.length);

		for (String namePart : nameParts) {
			final int length = titleBuilder.length();
			titleBuilder.append(namePart)
				.replace(length,
					(length + 1),
					Character.toString(namePart
							.codePointAt(0))
						.toUpperCase(Locale.ROOT));
		}

		final String unknownTitleName = titleBuilder.toString();
		titleNames.put(name, unknownTitleName);
		return unknownTitleName;
	}

	private static void capitaliseParentAndChildNames(
					Map<String, String> titlePackNames,
					String packName,
					String[] packNameParts,
					String[] parentChildNamePair)
	{
		assert (parentChildNamePair.length > 1);
		parentChildNamePair[0] = asRunOnTitleString(
			titlePackNames,
			packName,
			packNameParts);
		parentChildNamePair[1] = asRunOnTitleString(
			titlePackNames,
			(packNameParts.length > 1)
				? packName.substring(
					0,
					(packName.length() -
						packNameParts[packNameParts.length - 1]
							.length() - 1))
				: "",
			Arrays.copyOfRange(
				packNameParts,
				0,
				Math.max(0, (packNameParts.length - 1))));
	}

	private static void generateTypeNameSyntaxItems(
			PrintWriter writer,
			Pattern dotParser,
			Set<String> edgePackNames,
			Map<String, Map<String, Set<String>>> groupedTypeNames,
			Map<String, String> modNames)
	{
		/* Parts for opt-in guards. */
		final BiConsumer<StringBuilder, StringBuilder> guardMaker =
						(headBuilder, tailBuilder) ->
			headBuilder.append(" || exists(\"g:")
				.append(tailBuilder)
				.append("\")");
		final String prefixName = "java_highlight";

		/* The templets to use for generation. */
		final String allGuardModStartTemplet =
			"if exists(\"g:java_highlight_all\")%s" +
			"%n  \" %s/%s";
		final String allGuardStartTemplet =
			"if exists(\"g:java_highlight_all\")%s" +
			"%n  \" %s";
		final String allGuardEndTemplet = "%nendif%n%n";
		final String genericsGuardStartTemplet =
			"%n%n  if !exists(\"g:java_highlight_generics\")";
		final String genericsGuardEndTemplet = "%n  endif%n";
		final String hiGroupsTemplet =
			"%n  hi def link java%3$s_%1$s java%3$s_%2$s";
		final String synItemsTemplet =
			"%n  %5$ssyn keyword java%3$s_%1$s %4$s" +
			"%n  %5$ssyn cluster javaClasses add=java%3$s_%1$s" +
			"%n  %5$shi def link java%3$s_%1$s java%3$s_%2$s";

		/* PascalCased package names. */
		final Map<String, String> titlePackNames = new HashMap<>();

		for (Map.Entry<String, Map<String, Set<String>>> pack :
						groupedTypeNames.entrySet()) {
			final boolean isParentPack = (pack.getKey()
							.endsWith("\u0020"));
			final String packName = (isParentPack)
				? pack.getKey().stripTrailing()
				: pack.getKey();
			final String modName = modNames.get(packName);
			final String[] packNameParts = dotParser.split(
								packName);
			final String[] packNamePair = {"", ""};
			capitaliseParentAndChildNames(titlePackNames,
							packName,
							packNameParts,
							packNamePair);

			if (modName != null) {
				modNames.remove(packName);
				writer.format(allGuardModStartTemplet,
						asGrownPrefixString(
							guardMaker,
							"_",
							prefixName,
							packNameParts),
						modName,
						packName);
			} else {
				writer.format(allGuardStartTemplet,
						asGrownPrefixString(
							guardMaker,
							"_",
							prefixName,
							packNameParts),
						packName);
			}

			if (isParentPack) {
				for (String groupName :
						pack.getValue().keySet())
					writer.format(hiGroupsTemplet,
							packNamePair[0],
							packNamePair[1],
							groupName);
			} else {
				for (Map.Entry<String, Set<String>> group :
						pack.getValue().entrySet()) {
					final String classNames = asString(
						"\u0020",
						group.getValue().iterator());
					final String groupOtherName =
							group.getKey();
					final String groupName = ("_C".equals(
							groupOtherName))
						? "C"
						: ("_I".equals(groupOtherName))
							? "I"
							: groupOtherName;

					if (groupOtherName.startsWith("_")) {
						writer.format(genericsGuardStartTemplet)
							.format(synItemsTemplet,
								packNamePair[0],
								packNamePair[1],
								groupName,
								classNames,
								"\u0020\u0020")
							.format(genericsGuardEndTemplet);
					} else if (!group.getValue().isEmpty()) {
						writer.format(synItemsTemplet,
								packNamePair[0],
								packNamePair[1],
								groupName,
								classNames,
								"");
					} else if (edgePackNames.contains(
								packName)) {
						/*
						 * Cf. generic-only interface
						 * members of java.base/
						 * sun.reflect.generics.visitor.
						 */
						writer.format(hiGroupsTemplet,
								packNamePair[0],
								packNamePair[1],
								groupName);
					}
				}
			}

			writer.format(allGuardEndTemplet).flush();
		}
	}

	private static void linkSubpackages(
			Pattern dotParser,
			Set<String> edgePackNames,
			Map<String, Map<String, Set<String>>> groupedTypeNames)
	{
		final Map<String, Map<String, Set<String>>> typeNamesCopy =
						TypeNameSyntaxItemGenerator
				.<Map<String, Set<String>>>sortedMap();
		typeNamesCopy.putAll(groupedTypeNames);

		for (Map.Entry<String, Map<String, Set<String>>> pack :
						typeNamesCopy.entrySet()) {
			final String packName = pack.getKey();
			final Map<String, Set<String>> linkGroupNames =
						TypeNameSyntaxItemGenerator
					.<Set<String>>sortedMap();

			/*
			 * Mask "_[CI]"s as "[CI]"s and duplicate the latter
			 * when found for subpackages.
			 */
			for (String groupName : pack.getValue().keySet())
				linkGroupNames.put(("_C".equals(groupName))
					? "C"
					: ("_I".equals(groupName))
						? "I"
						: groupName,
					Set.of());

			final Set<String> parentPackNames = new HashSet<>();
			final StringBuilder packNameBuilder =
					new StringBuilder(packName.length());
			final String[] packNameParts = dotParser.split(
								packName);

			for (String part : Arrays.copyOfRange(
					packNameParts,
					0,
					Math.max(0, (packNameParts.length - 1)))) {
				final String parentPackName =
						packNameBuilder.append(part)
								.toString();
				final Map<String, Set<String>> packGroupNames =
						groupedTypeNames.get(
							parentPackName);

				if (packGroupNames == null) {
					groupedTypeNames.computeIfAbsent(
							parentPackName
								.concat("\u0020"),
							k -> TypeNameSyntaxItemGenerator
								.<Set<String>>sortedMap())
						.putAll(linkGroupNames);
				} else {
					for (String linkGroupName :
							linkGroupNames.keySet())
						packGroupNames.merge(
							linkGroupName,
							Set.of(),
							(oldValue, newValue) ->
								oldValue);
				}

				parentPackNames.add(parentPackName);
				packNameBuilder.append('.');
			}

			parentPackNames.remove(packName);
			edgePackNames.addAll(parentPackNames);
		}
	}

	private static String group(Class<?> type)
	{
		return (type.getTypeParameters().length > 0)
			? (type.isInterface())
				? "_I"
				: "_C"
			: (type.isInterface())
				? "I"
				: (RuntimeException.class.isAssignableFrom(type))
					? "R"
					: (Exception.class.isAssignableFrom(type))
						? "X"
						: (Error.class.isAssignableFrom(type))
							? "E"
							: "C";
	}

	private static String parseInTypeName(Pattern parser, String candidate)
	{
		final Matcher matcher = parser.matcher(candidate);
		final String typeName;
		return (matcher.find() && (typeName = matcher.group(1)) != null)
			? typeName.replace('/', '.')
			: candidate;
	}

	private static Class<?> findPublicOrProtectedType(String typeName,
							ClassLoader loader)
	{
		final Class<?> type;

		try {
			type = Class.forName(typeName, false, loader);
		} catch (final ReflectiveOperationException e) {
			e.printStackTrace();
			return null;
		}

		Class<?> member = type;

		do {
			/*
			 * Reject non-API types and nested API types that are
			 * members of non-API types.
			 */
			if (!(((Modifier.PUBLIC | Modifier.PROTECTED) &
						member.getModifiers()) != 0))
				return null;
		} while ((member = member.getEnclosingClass()) != null);

		return type;
	}

	private static void findAndGroupTypeNames(
			BufferedReader reader,
			ClassLoader loader,
			Map<String, Map<String, Set<String>>> groupedTypeNames,
			Map<String, String> modNames) throws IOException
	{
		/* The ‘parser’ of file- and type-names of named packages. */
		final Pattern typeNameParser = Pattern.compile(
			"^.*?((?:\\p{javaJavaIdentifierStart}\\p{javaJavaIdentifierPart}*?[/.](?!class$))+" +
			"\\p{javaJavaIdentifierStart}\\p{javaJavaIdentifierPart}*)");
		String candidate;

		while ((candidate = reader.readLine()) != null) {
			final Class<?> type = findPublicOrProtectedType(
				parseInTypeName(typeNameParser, candidate),
				loader);

			if (type == null)
				continue;

			final String groupName = group(type);
			final String packName = type.getPackageName();
			final String modName = type.getModule().getName();
			modNames.put(packName,
					(modName == null)
						? "[unnamed]"
						: modName);
			groupedTypeNames.computeIfAbsent(
					packName,
					k -> TypeNameSyntaxItemGenerator
						.<Set<String>>sortedMap())
				.computeIfAbsent(
					groupName,
					k -> TypeNameSyntaxItemGenerator
						.<String>sortedSet())
				.add(type.getSimpleName());
		}
	}

	private static <E> Set<E> sortedSet()
	{
		return new TreeSet<>();
	}

	private static <E> Map<String, E> sortedMap()
	{
		return new TreeMap<>();
	}

	/**
	 * Attempts to generate optional syntax items for a list of requested
	 * types whose runtime instances are discoverable.  Each listed type
	 * must have a {@link Class#getCanonicalName canonical name} that is
	 * written out on a separate line either in fully-qualified form or as
	 * a relative path to its class file.
	 *
	 * @param args optional command-line arguments: the input pathname to
	 *	a file with a list of requested types, one type per line, to
	 *	generate syntax items for; followed by the output pathname to
	 *	a file where to store generated syntax items; otherwise, the
	 *	standard input and/or output streams are used
	 * @throws IOException if an I/O error occurs
	 * @see Class#forName(String, boolean, ClassLoader)
	 */
	public static void main(String[] args) throws IOException
	{
		/* The class loader to use for loading requested types. */
		final ClassLoader loader = TypeNameSyntaxItemGenerator.class
			.getClassLoader();

		/* The ‘parser’ of package-names. */
		final Pattern dotParser = Pattern.compile("\\.");

		/* Scratch structures. */
		final Set<String> edgePackNames = new HashSet<>();
		final Map<String, String> modNames = new HashMap<>();
		final Map<String, Map<String, Set<String>>> groupedTypeNames =
						TypeNameSyntaxItemGenerator
				.<Map<String, Set<String>>>sortedMap();

		try (Reader ir = (args.length > 0 && !("-".equals(args[0])))
					? new FileReader(args[0],
						Charset.defaultCharset())
					: new InputStreamReader(System.in) {
						@Override public void close() { }
					};
				BufferedReader reader = new BufferedReader(ir)) {
			findAndGroupTypeNames(reader,
						loader,
						groupedTypeNames,
						modNames);
		}

		/* Ensure that there is a ":hi-link" for every subpackage. */
		linkSubpackages(dotParser, edgePackNames, groupedTypeNames);

		try (Writer ow = (args.length > 1)
					? new FileWriter(args[1],
						Charset.defaultCharset())
					: new OutputStreamWriter(System.out) {
						@Override public void close() { }
					};
				Writer bw = new BufferedWriter(ow);
				PrintWriter writer = new PrintWriter(bw, false)) {
			generateTypeNameSyntaxItems(writer,
						dotParser,
						edgePackNames,
						groupedTypeNames,
						modNames);
		}
	}
}
