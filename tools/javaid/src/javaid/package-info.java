/**
 * Provides syntax item generation for type names.
 * <p>
 * In order to enable the recognition of selected type names in Vim, proceed
 * as follows:<ol>
 * <li>Apply a name filter to an arbitrary class-file list.
 * <li>Pass the filtered list to {@link TypeNameSyntaxItemGenerator} and let
 *	it generate a new syntax file; name the new file {@code javaid.vim}.
 * <li>Copy that file to one of {@code runtime/syntax} directories.
 * <li>In Vim, define opt-in variables that guard desired syntax items, e.g.
 *	{@code g:java_highlight_all}, and re-link some highlighting groups,
 *	e.g. {@code javaC_}, {@code javaE_}, {@code javaI_}, {@code javaR_},
 *	{@code javaX_} (respectively grouping names for classes etc., errors,
 *	interfaces etc., runtime exceptions, and checked exceptions).
 * </ol>
 * <p><b>Generation examples</b>
 * <pre>{@code
 * echo javaid/TypeNameSyntaxItemGenerator.class | java javaid.TypeNameSyntaxItemGenerator
 * jar tf /tmp/acme.jar | grep '\.class$' | java -cp .:/tmp/acme.jar javaid.TypeNameSyntaxItemGenerator
 * jimage list $JDK_ROOT_DIR/lib/modules | grep -F java/io | java javaid.TypeNameSyntaxItemGenerator
 * java javaid.TypeNameSyntaxItemGenerator [< ]/tmp/classlist [> ]~/.vim/syntax/javaid.vim
 * }</pre>
 *
 * @since 11 (JDK)
 */
package javaid;
