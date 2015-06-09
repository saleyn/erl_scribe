##
## Makefile
##
## Made by Christopher Zorn <tofu@thetofu.com>
##
## Started on  Mon Nov  2 16:50:29 2009 Christopher Zorn
## Last update Mon Nov  2 16:50:29 2009 Christopher Zorn
##

#####################
# Macro Definitions #
#####################
ERL 	= erl
ERLC    = erlc
MAKE 	= make
SHELL	= /bin/sh
RM 	= /bin/rm -rf


##############################
# Basic Compile Instructions #
##############################

all: build

gen: thrift build

build:
	cp src/*.app ebin/
	erlc +debug_info -o ebin -I ./include $(filter-out src/example.erl, $(wildcard src/*.erl))

thrift:
	thrift --gen erl scribe.thrift
	cp example.erl gen-erl
	cp -f gen-erl/*.erl src/
	cp -f gen-erl/*.hrl include/

clean:
	-$(RM) gen-erl
	-$(RM) ebin/*
