BUILD=build
PUBLIC=${BUILD}/public

export PATH := $(shell pwd)/node_modules/.bin:$(PATH)

## Virtual ##

.PHONY: install coffee clean

install: coffee node_modules assets

coffee: node_modules
	coffee -c -l -b -o build/app app
	coffee -c -l -b -o build server.coffee

clean:
	rm -rf build
	rm -rf node_modules
	$(MAKE) -C app/vendor/bootstrap clean

assets: bootstrap styles scripts

styles:
	$(MAKE) build/public/css/main.css

scripts:
	$(MAKE) build/public/js/main.js

bootstrap: ${PUBLIC}
	$(MAKE) -C app/vendor/bootstrap bootstrap
	cp -r app/vendor/bootstrap/bootstrap ${PUBLIC}

## Real ##

node_modules: package.json 
	npm install

build/public/css/%.css: app/styles/%.less
	lessc $< $@

build/public/js/%.js: app/scripts/%.coffee
	coffee -c -l -o build/public/js $<
