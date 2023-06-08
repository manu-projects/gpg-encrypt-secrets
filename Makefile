SHELL:=/bin/bash

DIR_BASE=gpg-encrypt-secrets

# TODO: refactor, foreach ?
ifeq ("$(wildcard $(DIR_BASE))","")
include config.mk
include includes/template.mk
include includes/utils.mk
include includes/git.mk
include includes/encrypt.mk
include includes/decrypt.mk
else
include $(DIR_BASE)/config.mk
#include $(DIR_BASE)/includes/template.mk
include $(DIR_BASE)/includes/utils.mk
include $(DIR_BASE)/includes/git.mk
include $(DIR_BASE)/includes/encrypt.mk
include $(DIR_BASE)/includes/decrypt.mk
endif

init:
	cd .. \
	&& echo "include $(DIR_BASE)/Makefile" >> Makefile \
	&& make --no-print-directory update-gitignore

.PHONY: init
