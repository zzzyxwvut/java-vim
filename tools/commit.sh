#!/bin/sh -e

assets=tools/assets.txt

test -d "${1:?No such directory}" && test -x "$1" || exit 114
test -r "$1/${assets}"		|| exit 115
test -x "`command -v git`"	|| exit 116
test -x "`command -v cat`"	|| exit 117

case "`git status --porcelain=v1`" in
'')	;;
*)	printf >&2 'Resolve ALL changes before committing.\n'
	exit 118
	;;
esac

case "`git remote get-url --push "${3:-fork}"`" in
*zzzyxwvut/vimvim*)
	;;
*)	printf >&2 'Cannot proceed for an unknown remote.\n'
	exit 119
	;;
esac

case "`git branch --show-current`" in
master)	printf >&2 'Cannot apply changes to "master".\n'
	exit 120
	;;
*)	;;
esac

git fetch "$1" "${2:-master}" &&
git checkout FETCH_HEAD -- `cat "$1/${assets}"` &&
git commit --reedit-message=FETCH_HEAD
