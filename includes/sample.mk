SAMPLE_DIRS=mutt telegram tut

create-samples:
	@$(foreach DIR, $(SAMPLE_DIRS), \
		mkdir --verbose --parents sample/$(DIR)/configs \
		&& touch sample/$(DIR)/configs/$(DIR).$(SECRET_FILE_EXTENSION); \
	)

update-all-samples:
	@$(foreach DIR, $(SAMPLE_DIRS), \
		echo "key_id=123" >> sample/$(DIR)/configs/$(DIR).$(SECRET_FILE_EXTENSION); \
	)

delete-samples:
	@rm --verbose --recursive sample
