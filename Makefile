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

SRCS=$(SRCD)/terdbox.c
SRCS+=$(SRCD)/input.c
SRCS+=$(SRCD)/memstream.c
SRCS+=$(SRCD)/ringbuffer.c
SRCS+=$(SRCD)/term.c
SRCS+=$(SRCD)/utf8.c

OBJS:=$(patsubst $(SRCD)/%.c,$(OBJD)/$(SRCD)/%.o,$(SRCS))

.PHONY:all
all:$(LIBD)/lib$(NAME).a

$(OBJD)/%.o:%.c
	@echo "building source object $@"
	@mkdir -p $(@D)
	@$(CC) $(INCL) $(FLAGS) -c -o $@ $<

$(LIBD)/lib$(NAME).a:$(OBJS)
	@echo "compiling $@"
	@mkdir -p $(LIBD)
	@ar rvs $(LIBD)/lib$(NAME).a $(OBJS)

clean:
	@echo "cleaning workspace"
	@rm -rf $(LIBD)
	@rm -rf $(OBJD)
