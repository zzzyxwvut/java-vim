#!/bin/sh -e

assets=tools/assets.txt
branch=https://raw.githubusercontent.com/vim/vim/master/
origin=https://github.com/vim/vim.git

test -r "${assets}"		|| exit 115
test -x "`command -v git`"	|| exit 116
test -x "`command -v cat`"	|| exit 117

case "`git status --porcelain=v1`" in
'')	;;
*)	printf >&2 'Resolve ALL changes before rebasing.\n'
	exit 118
	;;
esac

bundle_assets()
{
	b="$1"
	u=''
	shift

	for n
	do
		u="$u$b$n "
	done

	printf '%s' "$u"
}

fetch_sha()
{
	git ls-remote --heads --quiet "${origin}" master | {
		read s rest
		printf '%s' "$s"
	}
}

s=0

if test "`command -v wget`"
then
	a=`cat "${assets}"`
	u="`bundle_assets "${branch}" $a`"
	s="`fetch_sha`"

	# The exit status range for wget(1): [0-8] (v1.21.4).
	wget --verbose --force-directories --no-host-directories --cut-dirs=3 \
		--directory-prefix . $u
elif test "`command -v curl`"
then
	a=`cat "${assets}"`
	u="`bundle_assets "${branch}" $a`"
	f=''

	for n in $a
	do
		f="$f--output $n "
	done

	s="`fetch_sha`"

	# The exit status range for curl(1): [0-99] (v8.5.0: -14).
	curl --verbose --create-dirs --output-dir . $f $u
else
	printf >&2 'Neither curl(1) nor wget(1) is found.\n'
	exit 119
fi

case "`fetch_sha`" in
"$s")	cat - "${assets}" > COMMIT_MSG <<EOF
Bring in published assets

$s/runtime/syntax/java.vim

EOF
	;;
*)	printf >&2 'HEAD revisions differ. Please try again.\n'
	exit 120
	;;
esac
