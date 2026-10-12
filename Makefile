.PHONY: build test deploy deploy-check bench deploy-bench

GO ?= go
ANSIBLE_PLAYBOOK ?= ansible-playbook
ANSIBLE_INVENTORY ?= ansible/inventory.yaml

# Build and test locally with the Go toolchain on PATH (or GO=...).
build:
	$(MAKE) -C go build GO="$(GO)"

test:
	$(MAKE) -C go test GO="$(GO)"

# deploy.yaml copies source and builds with the Go toolchain on the app server.
deploy:
	$(ANSIBLE_PLAYBOOK) -i $(ANSIBLE_INVENTORY) ansible/deploy.yaml

deploy-check:
	$(ANSIBLE_PLAYBOOK) -i $(ANSIBLE_INVENTORY) ansible/deploy.yaml --check --diff

# Trigger the benchmark command configured for the benchmarker host.
bench:
	$(ANSIBLE_PLAYBOOK) -i $(ANSIBLE_INVENTORY) ansible/bench.yaml

deploy-bench:
	$(MAKE) deploy
	$(MAKE) bench
