# TODO: refactor de los pipelines, la expansión de las macros de utils.mk generan errores en el Makefile
SECRET_FILES=$(shell cat secret-files.list \
	| awk '!/^\#/' \
	| tr '\n' ' ' \
)

SECRET_DIRECTORIES=$(shell cat secret-directories.list \
	| awk '!/^\#/' \
	| tr '\n' ' ' \
)

SECRET_FILES_FROM_DIRS=$(shell find $(SECRET_DIRECTORIES) -type f -name '*.$(SECRET_FILE_EXTENSION)' \
	| awk '!/^\#/' \
	| tr '\n' ' ' \
)

SECRETS=$(SECRET_FILES) $(SECRET_FILES_FROM_DIRS)

ENCRYPTED_SECRETS=$(SECRETS:.$(SECRET_FILE_EXTENSION)=.$(ENCRYPTED_SECRET_EXTENSION))
#ENCRYPTED_SECRETS=$(subst .$(SECRET_FILE_EXTENSION),.$(ENCRYPTED_SECRET_EXTENSION),$(SECRETS))

# Target de Seguimiento
# --------------------
#
# - marcamos el último momento que se produjo un evento (encriptado de ficheros)
# - por lo general éste target tiende a ser un fichero vacío, pero preferimos que se comporte como un log
# - compara el timestamp se actualización del target (fichero) con el de los ficheros encriptados,
# provocando que compare el timestamp de actualización de los ficheros encriptados con el de los secretos
encrypted-files-update: $(ENCRYPTED_SECRETS)
	@echo "$(DATE_NOW) $?" | tee --append $@

# Regla Implícita de Patrón
# -------------------------
#
# - compara el timestamp del patrón de ambos archivos (%.ext1 y %.ext2)
# - encripta el secreto sólo si el timestamp del archivo secreto es más reciente que el encriptado
%.$(ENCRYPTED_SECRET_EXTENSION): %.$(SECRET_FILE_EXTENSION)
	@echo "encriptando $*.$(SECRET_FILE_EXTENSION) como $@"
	@gpg \
		--output="$@" \
		--encrypt \
		--recipient="$(GPG_SUBKEY_ENCRYPTED_ID)" \
		$*.$(SECRET_FILE_EXTENSION)

%.$(SECRET_FILE_EXTENSION):
	@echo "desencriptando $* como $@"
	@gpg \
		--output="$@" \
		--decrypt \
		--recipient="$(GPG_SUBKEY_ENCRYPTED_ID)" \
		$*.$(ENCRYPTED_SECRET_EXTENSION)
