# suponemos que sólo existen los ficheros encriptados
ENCRYPTED_SECRETS_FROM_DIRS=$(shell find $(LIST_SECRET_DIRECTORIES) -type f -name '*.$(ENCRYPTED_SECRET_EXTENSION)' \
	| awk '!/^\#/' \
	| tr '\n' ' ' \
)

# $(subst palabra_buscada, palabra_nueva, texto)
DECRYPTED_SECRETS_FROM_DIRS=$(subst .encrypted,.secrets.txt,$(ENCRYPTED_SECRETS_FROM_DIRS))

DECRYPTED_SECRETS=$(sort $(LIST_SECRET_FILES) $(DECRYPTED_SECRETS_FROM_DIRS))

decrypted-files-update: $(DECRYPTED_SECRETS)
	@echo "$(DATE_NOW) $?" | tee --append $@

# Regla Implícita de Patrón
%.$(SECRET_FILE_EXTENSION):
	@echo "desencriptando $* como $@"
	@gpg \
		--output="$@" \
		--decrypt \
		--recipient="$(GPG_SUBKEY_ENCRYPTED_ID)" \
		$*.$(ENCRYPTED_SECRET_EXTENSION)
