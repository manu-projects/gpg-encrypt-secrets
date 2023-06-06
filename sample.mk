SAMPLE_DIRS=mutt telegram tut

create-samples:
	@$(foreach DIR, $(SAMPLE_DIRS), \
		mkdir --verbose --parents sample/$(DIR)/configs \
		&& touch sample/$(DIR)/configs/$(DIR).secrets.txt; \
	)

update-all-samples:
	@$(foreach DIR, $(SAMPLE_DIRS), \
		echo "key_id=123" >> sample/$(DIR)/configs/$(DIR).secrets.txt; \
	)

delete-samples:
	@rm --verbose --recursive sample
