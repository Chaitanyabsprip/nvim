install-plugins:
	nvim --headless "+Lazy! sync" +qa

update-plugins: install-plugins
	git add lazy-lock.json
	git commit -m 'chore: update plugins'

tree:
	@cd scripts && ./gen.sh

doc-build: tree
	cd scripts && typst compile ./config-documentation.typ --root ..

