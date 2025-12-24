#!/bin/bash

depends eza || exit 1

main() {
	gen_manifest
	gentree >directory-structure.ls
}

gentree() {
	cd "$(dirname "$0")" || exit 1

	tree -I '.git' -P '*.lua' -P '*.vim' -P '*.scm' ..
}

gen_manifest() {
	echo "[" >files.json
	find .. -type d -name ".git" -prune -o -type f \( \
		-name "*.lua" -o -name "*.scm" -o -name "*.vim" \
		\) -print | sort | while read -r file; do
		echo "  \"$file\"," >>files.json
	done
	sed -i '' '$ s/,$//' files.json
	echo "]" >>files.json
}

main "$@"
