BUILD=build
PUBLIC=${BUILD}/public
CCOFFEE=coffee -c -l -b -o

export PATH := $(shell pwd)/node_modules/.bin:$(PATH)

## Core ##

.PHONY: build

default:
	@echo "Hello"

develop:
	ln -sf Procfile.develop Procfile

release: build
	ln -sf Procfile.release Procfile

clean:
	rm -rf build
	rm -rf node_modules
	rm -f  Procfile

## Support ##

build:
	${CCOFFEE} build server.coffee
	${CCOFFEE} build/config config
	${CCOFFEE} build/app    app
	${CCOFFEE} build/lib    lib
