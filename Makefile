sync:
	rsync -av --delete-after --exclude=.* ./website/_build_prod/htdocs/ ./gh-pages/
