.PHONY: build clean deploy

build:
	env GOOS=linux go build -ldflags="-s -w" -o bin/slack slack/slack.go
clean:
	rm -rf ./bin