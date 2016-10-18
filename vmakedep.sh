#!/bin/sh

set -e

ivlbase='/usr/lib64/ivl'
ivlpp="$ivlbase/ivlpp"

if [ $# -eq 0 ]; then
	echo "Usage: vmakedep file.[s]v ..." >&2
	exit 2
fi

getdeps() {
	E=$($ivlpp -L -- "$1") || exit 1
	printf "%s" "$E"
}

filter() {
	awk '
BEGIN {
	target=ARGV[1];
	delete ARGV[1];
}
/^`line/ {
	if (match($0, "^`line [0-9]+ \"(.*)\" [0-9]+$", m)) {
		if (m[1] != target)
			a[m[1]]++;
	}
}
END {
	for (file in a)
		print file;
}' "$1"
}

for file in "$@"; do
	printf "%s: %s\n" "$file" "$(getdeps "$file" | filter "$file" | tr '\n' ' ' | sed 's/ *$//')"
done
