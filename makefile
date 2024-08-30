install-plugins:
	nvim --headless "+Lazy! sync" +qa

update-plugins: install-plugins
	git add lazy-lock.json
	git commit -m 'chore: update plugins'
