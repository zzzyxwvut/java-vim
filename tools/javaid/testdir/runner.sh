#!/bin/sh -e

: "${JDK_11_ROOT_DIR:?}"
cd "$(dirname "$0")"/..

classlist=testdir/filtered_modules_classlist
trap 'rm -f "$classlist"' EXIT HUP INT QUIT TERM
jimage list "$JDK_11_ROOT_DIR/lib/modules" | \
	grep -E '^\s*(java/|sun/management/)' > "$classlist"
javac -d bin --release 11 -Xdiags:verbose -Xlint \
	src/javaid/TypeNameSyntaxItemGenerator.java

grep -E '^\s*java/lang/[^/]+\.class$' "$classlist" | \
	java -cp bin javaid.TypeNameSyntaxItemGenerator \
	- testdir/11_java_lang.vim
grep -E '^\s*java(/[^/]+){4,}.+\.class$' "$classlist" | \
	java -cp bin javaid.TypeNameSyntaxItemGenerator \
	- testdir/11_java_SPARSE_PREFIX.vim
grep -E '^\s*sun/management/.+\.class$' "$classlist" | \
	java -cp bin javaid.TypeNameSyntaxItemGenerator \
	- testdir/11_sun_management_PREFIX_MULTI_MODULE_WITH_GENERICS.vim
grep -E '^\s*module-info\.class$' "$classlist" | \
	java -ea:javaid -cp bin javaid.TypeNameSyntaxItemGenerator \
	> testdir/11_GI_GO.vim

git diff --exit-code -- testdir/
