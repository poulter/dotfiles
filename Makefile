IGNORE:= . .. .git Makefile %.swp .gitignore .gitmodules

DIR:=$(notdir $(shell pwd))

FILES :=$(wildcard * .*)
LINKS :=$(filter-out $(IGNORE),$(FILES))
LINKS :=$(addprefix ../,$(LINKS))

BFILES:=$(wildcard bin/*)
BLINKS:=$(filter-out $(IGNORE),$(BFILES))
BLINKS:=$(addprefix ../,$(BLINKS))

SUBMODULES:=$(shell grep "path = " .gitmodules)
SUBMODULES:=$(filter-out path =,$(SUBMODULES))
SUBMODULES:=$(addsuffix /.git,$(SUBMODULES))

default:
	make -L all

all: $(LINKS) $(BLINKS) $(SUBMODULES)

##############################
######## create links ########
##############################
$(LINKS):%:${notdir $@}
	cd ../; ln -s $(DIR)/${notdir $@} ${notdir $@} 
##############################

##################################
######## create bin links ########
##################################
$(BLINKS):%:${notdir $@}
	cd ../bin; ln -s $(DIR)/bin/${notdir $@} ${notdir $@}
##################################

###################################
######## update submodules ########
###################################
$(SUBMODULES):.gitmodules-changed
	touch $@
.gitmodules-changed:.gitmodules
	git submodule init
	git submodule update
.INTERMEDIATE: .gitmodules-changed
###################################

##########################
######## settings ########
##########################
.DELETE_ON_ERROR:
##########################
