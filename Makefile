BUILD=build

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

assets: bootstrap ${BUILD}/public
	mkdir -p ${BUILD}/public/css
	$(MAKE) build/public/css/main.css

bootstrap: ${BUILD}/public
	$(MAKE) -C app/vendor/bootstrap bootstrap
	cp -r app/vendor/bootstrap/bootstrap ${BUILD}/public

## Real ##

node_modules: package.json 
	npm install

${BUILD}/public:
	mkdir -p ${BUILD}/public

build/public/css/%.css: app/styles/%.less ${BUILD}/public
	lessc $< $@
