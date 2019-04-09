CFLAGS ?= -Wall -pedantic -ansi

target = inetfuncs
sources = $(target).c

.PHONY: all
all:	$(target).so $(target).dll

.PHONY: clean
clean:
	rm -f $(target).dll $(target).so

$(target).so:	$(sources)
	gcc -g -fPIC -shared $(sources) -o $(target).so

$(target).dll:	$(sources)
	i686-w64-mingw32-gcc -g -shared $(sources) -o $(target).dll

