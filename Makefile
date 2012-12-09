BUILD=build
PUBLIC=${BUILD}/public

export PATH := $(shell pwd)/node_modules/.bin:$(PATH)

## Virtual ##

.PHONY: install coffee clean

install: coffee styles scripts bootstrap

coffee: node_modules
	coffee -c -l -b -o build/app app
	coffee -c -l -b -o build server.coffee

assets: bootstrap styles scripts

styles:
	$(MAKE) ${PUBLIC}/css/main.css

scripts:
	coffee -j main.js -l -o build/public/js/ app/scripts/

bootstrap:
	mkdir -p ${PUBLIC}
	$(MAKE) -C app/vendor/bootstrap bootstrap
	cp -r app/vendor/bootstrap/bootstrap ${PUBLIC}

clean:
	rm -rf build
	rm -rf node_modules
	$(MAKE) -C app/vendor/bootstrap clean

## Real ##

node_modules: package.json 
	npm install

${PUBLIC}/css/%.css: app/styles/%.less
	mkdir -p ${PUBLIC}/css
	lessc $< $@

${PUBLIC}/js/%.js: app/scripts/%.coffee
	mkdir -p ${PUBLIC}/js
	coffee -c -l -o ${PUBLIC}/js $<

${BUILD}/app/views:
	cp -r app/views build/app/views
