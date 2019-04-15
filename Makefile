##
## Magic Makefile
##

DOCKER_REPO ?= $(subst .,/,$(notdir $(PWD)))
DOCKER_TAG ?= latest

BUILD_PATH ?= .
DOCKERFILE_PATH ?= $(BUILD_PATH)/Dockerfile

COMMA = ,
SPACE ?= $() $()
ALL_TAGS = $(subst $(COMMA),$(SPACE),$(DOCKER_TAG))

TAG_LIST = $(foreach tag,$(ALL_TAGS),-t "$(DOCKER_REPO):$(tag)")

random-shit: DOCKER_TAG=master,test-master,foobar
random-shit: build
	: echo ${TAG_LIST}
	: echo ${DOCKER_TAG}
	: echo ${ALL_TAGS}

build:
	: docker image build ${TAG_LIST} $(foreach arg,$(BUILD_ARGS),--build-arg $(arg)) -f "$(DOCKERFILE_PATH)" "$(BUILD_PATH)"

push:
	docker image push "$(DOCKER_REPO):$(DOCKER_TAG)"

tag:
	docker image tag "$(DOCKER_REPO):$(DOCKER_TAG)" "$(DOCKER_REPO):$(TARGET_TAG)"

test:
	$(MAKE) build DOCKER_TAG=$(firstword $(ALL_TAGS))
	$(foreach var,$(wordlist 2,$(words $(ALL_TAGS)),$(ALL_TAGS)), $(MAKE) tag DOCKER_TAG=$(firstword $(ALL_TAGS)) TARGET_TAG=$(var);)

test_one:
	echo $(DOCKER_TAG)
