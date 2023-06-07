GIT_IGNORE_FILES=sample encrypted-files-update decrypted-files-update \*.$(SECRET_FILE_EXTENSION)

init-gitignore:
ifeq ($(shell grep ".$(SECRET_FILE_EXTENSION)" .gitignore && echo 1 || echo 0), 0)
	@$(foreach FILE, $(GIT_IGNORE_FILES), \
		echo $(FILE) >> .gitignore; \
	)
endif
