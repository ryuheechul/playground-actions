.PHONY: build
build:
	docker buildx build -t local/playground-actions/run --target test .

build-for-act:
	docker buildx build -t act-github-actions-run-dockeraction:latest --target test .

