G=\033[0;32m
B=\033[0;36m
P=\033[0;35m
N=\033[0m
K=$G√$N
INFO=$P[INFO]$N
DONE=$B[DONE]$N

BUILD=build
PUBLIC=${BUILD}/public
CCOFFEE=env coffee -c -l -b -o
M=node_modules

export PATH := $(shell pwd)/node_modules/.bin:$(PATH)

## Core ##

.PHONY: build

default:
	@echo 
	@echo "Usage: make [command]"
	@echo 
	@echo "Commands:"
	@echo 
	@echo "  develop       use source and reload on changes development"
	@echo "  release       compile scripts for release"
	@echo "  clean         remove all generated content"
	@echo
	@echo "Sub-Commands:"
	@echo
	@echo "  install       install node modules with npm"
	@echo "  require       compile and optimize require.js modules"
	@echo

develop: install link-src
	@echo "${INFO} Using Development Mode"
	@rm -f  public
	@mkdir -p tmp/public/styles
	@ln -sf Procfile.develop Procfile
	@ln -sf ../../vendor/requirejs/require.js tmp/public/
	@ln -sf tmp/public public
	@echo "${INFO} Application Ready"
	@echo "${DONE} Use 'nf start' to run"
	
release: install build link-bin require
	@ln -sf Procfile.release Procfile
	@echo "${INFO} ----> Copying Views"
	@cp -r  app/views build/app/views
	@echo "${INFO} ----> Copying Public Content"
	@mkdir -p build/public
	@cp vendor/requirejs/require.js build/public
	@echo "${INFO} ----> Compiling Stylus"
	@mkdir -p build/public/styles
	@env stylus --compress --out build/public/styles client/stylus
	@echo "${INFO} Application Ready"
	@echo "${DONE} Use 'nf export -h' to view job export help"

clean:
	@echo "${INFO} $K Delete Build Directory"
	@rm -rf build
	@echo "${INFO} $K Delete Temp Directory"
	@rm -rf tmp
	@echo "${INFO} $K Clean Up"
	@rm -f  Procfile
	@rm -f  public
	@echo "${DONE} Done"

## Release ##

require:
	@echo "${INFO} ----> Compiling RequireJS"
	@mkdir -p tmp/scripts
	@mkdir -p build/public/scripts
	@env coffee -c -o tmp/scripts client/coffee
	@env r.js -o script/app.build.js >/dev/null 2>&1

define link-bin
	rm -f node_modules/$1
	ln -fs ../build/$1 node_modules/$1
endef

build: install
	@echo "${INFO} ----> Building Coffee Scripts"
	@${CCOFFEE} build server.coffee
	@${CCOFFEE} build/config config
	@${CCOFFEE} build/app    app
	@${CCOFFEE} build/lib    lib

link-bin: install
	@$(call link-bin,lib)

## Develop ##

define link-source
	rm -f node_modules/$1
	ln -fs ../$1 node_modules/$1
endef

link-src: install
	@$(call link-source,lib)

## All ##

install: node_modules

node_modules:
	npm install

