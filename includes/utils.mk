DATE_NOW=$(shell date +'%d-%m-%Y %H:%M:%S')

# TODO: genera errores en el Makefile
AWK_REMOVE_COMMENTS=awk '!/^\#/'
TR_REMOVE_NEWLINE=tr '\n' ' '
