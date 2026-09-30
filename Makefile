.PHONY: package-plugin test-plugin

package-plugin:
	./scripts/package-plugin.sh

test-plugin:
	./scripts/test-plugin-package.sh
