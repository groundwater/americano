BUILD=build
PUBLIC=${BUILD}/public
CCOFFEE=coffee -c -l -b -o
M=node_modules

export PATH := $(shell pwd)/node_modules/.bin:$(PATH)

## Core ##

.PHONY: build

default:
	@echo "Hello"

develop: install link-src
	ln -sf Procfile.develop Procfile
	ln -sf ../tmp/scripts public
	ln -sf ../vendor/requirejs/require.js public/

release: install build link-bin require
	ln -sf Procfile.release Procfile
	cp -r  app/views build/app/views
	cp -r  public    build/
	cp vendor/requirejs/require.js build/public

clean:
	rm -rf build
	rm -rf tmp
	rm -rf node_modules
	rm -f  Procfile
	find public -type l -exec rm -f {} \;

## Release ##

require:
	mkdir -p tmp/scripts
	mkdir -p build/public/scripts
	coffee -c -o tmp/scripts client/coffee
	env r.js -o script/app.build.js

define link-bin
	rm -f node_modules/$1
	ln -fs ../build/$1 node_modules/$1
endef

build: install
	${CCOFFEE} build server.coffee
	${CCOFFEE} build/config config
	${CCOFFEE} build/app    app
	${CCOFFEE} build/lib    lib

link-bin: install
	$(call link-bin,app)
	$(call link-bin,lib)

## Develop ##

define link-source
	rm -f node_modules/$1
	ln -fs ../$1 node_modules/$1
endef

link-src: install
	$(call link-source,app)
	$(call link-source,lib)

## All ##

install: node_modules

node_modules:
	npm install

