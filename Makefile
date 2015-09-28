run:
	./node_modules/webpack-dev-server/bin/webpack-dev-server.js --colors --devtool cheap-module-inline-source-map

build:
	./node_modules/webpack/bin/webpack.js -p --optimize-minimize --optimize-occurence-order --optimize-dedupe --progress --devtool source-map

deploy-demo: build
	mkdir -p demo/dist/
	cp css/style.css demo/
	cp ./dist/* demo/dist/
	cp ./node_modules/d3/d3.min.js demo/dist/
	git add demo/
	git commit -m "Update GitHub pages"
	git push origin :gh-pages
	git subtree push --prefix demo origin gh-pages
	git reset --soft HEAD~1 # undo the deployment commit
	git reset HEAD demo
	rm -Rf demo/dist/

test: karma mocha

karma:
	./node_modules/karma/bin/karma start test/karma/karma.conf.js --single-run

mocha:
	./node_modules/mocha/bin/mocha --compilers js:mocha-traceur --recursive test/mocha

install:
	npm install
