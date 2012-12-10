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

release: install build link-bin
	ln -sf Procfile.release Procfile
	

clean:
	rm -rf build
	rm -rf node_modules
	rm -f  Procfile

## Release ##

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

