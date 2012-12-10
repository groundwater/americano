BUILD=build
PUBLIC=${BUILD}/public
CCOFFEE=coffee -c -l -b -o

export PATH := $(shell pwd)/node_modules/.bin:$(PATH)

## Core ##

develop:
	ln -sf Procfile.develop Procfile

release:
	ln -sf Procfile.release Procfile

clean:
	rm -rf build
	rm -rf node_modules
	rm -f  Procfile
	$(MAKE) -C app/vendor/bootstrap clean

