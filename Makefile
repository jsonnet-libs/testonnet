.PHONY: docs
docs:
	rm -rf ./docs && \
	jsonnet -J ./vendor -S -c -m ./docs \
		--exec "(import 'doc-util/main.libsonnet').render(import 'main.libsonnet')"
