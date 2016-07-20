.DEFAULT_GOAL := help
.PHONY: help test

TEMPDIR := $(shell mktemp -d)

test: ## Execute all tests
	@for i in `find . -name terraform.\*.tfvars.example`; do \
		terraform plan -var-file $$i 1> $(TEMPDIR)/$$i.output && \
		diff tests/fixtures/$$i.output $(TEMPDIR)/$$i.output; \
		if [[ $$? -ne 0 ]] ; then exit 1; fi; \
	done
	@echo "Temp directory: $(TEMPDIR)"

help: ## Halp!
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
