BUILD_DIR:=build

version=$(shell jq -r ".version" package.json)
vsix=$(BUILD_DIR)/rl78-assembly-$(version).vsix

.PHONY: package
package: $(vsix)

.PHONY: install
install: $(vsix)
	code --install-extension $(vsix)

$(vsix): language-configuration.json package.json syntaxes/rl78.tmLanguage.json | $(BUILD_DIR)
	npx vsce package -o $@

$(BUILD_DIR):
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
