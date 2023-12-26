install: build
	@gem install ./postwoman.gem

build:
	@gem build postwoman.gemspec -o postwoman.gem
