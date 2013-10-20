IGNORE:= . .. .git Makefile %.swp .gitignore .gitmodules poulter.zsh-theme

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

###############################
######## miscellaneous ########
###############################
# poulter theme copied to oh-my-zsh
all: .oh-my-zsh/themes/poulter.zsh-theme .vim/plugin/autotag.vim

.oh-my-zsh/themes/poulter.zsh-theme: $(SUBMODULES)
	cd .oh-my-zsh/themes/; \
	  ln -s ../../$(notdir $@) .

.vim/plugin/autotag.vim: Makefile
	wget https://raw.github.com/craigemery/dotFiles/master/vim/plugin/autotag.vim
	mv autotag.vim .vim/plugin/autotag.vim 

###############################

##########################
######## settings ########
##########################
.DELETE_ON_ERROR:
##########################
