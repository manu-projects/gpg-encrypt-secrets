include *.env
include *.mk

SHELL:=/bin/bash

GIT_IGNORE_FILES=sample encrypted-files-update \*.secret.txt \*.secrets.txt

init-gitignore:
ifeq ($(shell grep ".[secret,secrets].txt" .gitignore && echo 1 || echo 0), 0)
	@$(foreach FILE, $(GIT_IGNORE_FILES), \
		echo $(FILE) >> .gitignore; \
	)
endif
