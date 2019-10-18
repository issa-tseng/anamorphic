.PHONY: build clean
default: build

XJS_IN = $(shell find src -name '*.xjs' | sort)
XJS_OUT = $(XJS_IN:src/%.xjs=lib/%.js)

FILES = lib/bundle.js lib/app.html lib/app.css

lib/%.js: src/%.xjs
	node node_modules/babel/packages/babel-cli/bin/babel.js $< --presets=@xjs > $@

lib/bundle.js: lib/app.js
	node node_modules/browserify/bin/cmd.js --exclude domino -e $< -o $@ --im

lib/app.%: src/app.%
	cp $< $@

lib/media: media
	ln -hs ../media lib/media
lib/films: films
	ln -hs ../films lib/films

build: $(XJS_OUT) $(JSON_OUT) $(FILES) lib/media lib/films

clean:
	rm -rf lib/*

