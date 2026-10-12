DEST=$(CURDIR)/bin/isucholar
GO?=go
GO_FILES=$(wildcard ./*.go ./**/*.go)

.PHONY: all build test
all: clean build ## Cleanup and Build

.PHONY: build
build: $(GO_FILES) ## Build executable files
	@mkdir -p $(dir $(DEST))
	@$(GO) build -o $(DEST) -ldflags "-s -w"

.PHONY: test
test: ## Run Go tests locally
	@$(GO) test ./...

.PHONY: clean
clean: ## Cleanup files
	@$(RM) -r $(DEST)

.PHONY: help
help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
