all: index.html

node_modules:
	npm install jade marked stylus coffee-script
	touch $@

index.html: node_modules index.jade
	node_modules/jade/bin/jade < index.jade > $@

publish: all
	- git checkout master
	- git branch -D gh-pages
	git checkout -b gh-pages
	git add -f index.html
	git commit -m '[PUBLISH] compiled index.html'
	- git push origin gh-pages -f
	git checkout master
	git branch -D gh-pages

.PHONY: all publish clean

clean:
	rm -Rf index.html node_modules