#
# Make file for building docker image. Install GnuMake for Windows 
# to build under Windows.
#  
# By Huxi LI, 2017, Paris
#
# Make: 
#      $ make [-e GROUP=GroupName]  
#
# ___________________

NAME = huxili/angular6-cli

# 1. Help 
# See https://stackoverflow.com/questions/649246/is-it-possible-to-create-a-multi-line-string-variable-in-a-makefile
# 
define HELP_BODY
-------------------------
Angualar6 cli 

Usage: make target
	
Target
========

- help: This help message  
- build: Build angular6-cli image
- start: Start application 
- sh: Open the container shell
- log: Show logs of the container
- rm: Remove the container

endef
export HELP_BODY

.PHONY: help deploy build status rm

help: 
	@echo "$$HELP_BODY"

build: build-image-with-cache
build-nocache: build-image-no-cache
start: run-test-image
starti: run-test-image-interactive
rm: remove-test-container
sh: run-container-shell
log: container-logs

build-image-no-cache:
	docker build --no-cache=true -t $(NAME) .
build-image-with-cache:
	docker build -t $(NAME) .
run-test-image: 
	docker rm -f test-angular6-cli 2>/dev/null || true 
	docker run -it -d --rm -v `pwd`:/app --name test-angular6-cli "$(NAME)"
remove-test-container:
	docker rm -f test-angular6-cli
run-container-shell:
	docker exec -it test-angular6-cli /bin/sh
container-logs:
	docker logs test-angular6-cli
