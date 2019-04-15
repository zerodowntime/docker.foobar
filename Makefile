##
## Magic Makefile
##

DOCKER_REPO ?= $(subst .,/,$(notdir $(PWD)))
DOCKER_TAG ?= latest

BUILD_PATH ?= /
DOCKERFILE_PATH ?= Dockerfile

COMMA = ,
SPACE ?= $() $()
ALL_TAGS = $(subst $(COMMA),$(SPACE),$(DOCKER_TAG))
TAG_LIST = $(foreach tag,$(ALL_TAGS),-t "$(DOCKER_REPO):$(tag)")
ARG_LIST = $(foreach arg,$(BUILD_ARGS),--build-arg "$(arg)")

.PHONY: all build push

all: build push

build:
	docker image build $(TAG_LIST) $(ARG_LIST) -f ".$(BUILD_PATH)/$(DOCKERFILE_PATH)" ".$(BUILD_PATH)"

push:
	$(foreach tag,$(ALL_TAGS),docker image push "$(DOCKER_REPO):$(tag)" &&) true
