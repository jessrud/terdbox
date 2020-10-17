NAME=terdbox
CC=gcc
FLAGS=-std=c99 -pedantic -Wall -Werror -g

OS:=$(shell uname -s)
ifeq ($(OS),Linux)
	FLAGS+=-D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE
endif

LIBD=lib
SRCD=src
OBJD=obj
INCL=-I$(SRCD)
PREFIX=/usr/local

SRCS=$(SRCD)/terdbox.c
SRCS+=$(SRCD)/input.c
SRCS+=$(SRCD)/memstream.c
SRCS+=$(SRCD)/ringbuffer.c
SRCS+=$(SRCD)/term.c
SRCS+=$(SRCD)/utf8.c

OBJS:=$(patsubst $(SRCD)/%.c,$(OBJD)/$(SRCD)/%.o,$(SRCS))

.PHONY: all clean install uninstall
	
all: $(LIBD)/lib$(NAME).a

$(OBJD)/%.o: %.c
	mkdir -p $(@D)
	$(CC) $(INCL) $(FLAGS) -c -o $@ $<

$(LIBD)/lib$(NAME).a: $(OBJS)
	mkdir -p $(LIBD)
	ar rvs $(LIBD)/lib$(NAME).a $(OBJS)

install: $(LIBD)/lib$(NAME).a
	install -m a+r,u+w $(LIBD)/lib$(NAME).a $(PREFIX)/lib
	install -m a+r,u+w $(SRCD)/$(NAME).h $(PREFIX)/include

uninstall:
	rm -f $(PREFIX)/lib/lib$(NAME).a
	rm -f $(PREFIX)/include/$(NAME).h


clean:
	rm -rf $(LIBD)
	rm -rf $(OBJD)

