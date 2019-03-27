##
## Magic Makefile
##

DOCKER_REPO ?= $(subst .,/,$(notdir $(PWD)))
DOCKER_TAG ?= latest

BUILD_PATH ?= .
DOCKERFILE_PATH ?= $(BUILD_PATH)/Dockerfile

build:
	docker image build -t "$(DOCKER_REPO):$(DOCKER_TAG)" $(foreach arg,$(BUILD_ARGS),--build-arg $(arg)) -f "$(DOCKERFILE_PATH)" "$(BUILD_PATH)"


push:
	docker image push "$(DOCKER_REPO):$(DOCKER_TAG)"


tag:
	docker image tag "$(DOCKER_REPO):$(DOCKER_TAG)"
