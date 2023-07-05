.PHONY: print-org
print-org:
	act -j print-org

.PHONY: uses-yq
uses-yq:
	act -j uses-yq

.PHONY: input-value-check
input-value-check:
	yq .act/events/input-value-check-default.yaml -o json \
		| act --env USER=bot -j input-value-check -e /dev/stdin

.PHONY: template
template:
	yq .act/events/template-default.yaml -o json | act --env USER=bot -j template -e /dev/stdin

.PHONY: nixery
nixery:
	act -j nixery

.PHONY: list
list:
	act workflow_dispatch -l

.PHONY: test-yq
test-yq:
	cd .github/workflows/uses-yq && $(MAKE) try

.PHONY: earthly
earthly:
	earthly --secret ENV_VAR_SECRET --allow-privileged +build --ENV_VAR_A=$(ENV_VAR_A)
