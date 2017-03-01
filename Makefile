PWD:= $(shell pwd)
UPDIR:=$(notdir $(PWD))

# don't make links to these
IGNORE:= . .. .git Makefile %.swp .gitignore .gitmodules poulter.zsh-theme bin git

# ./ is assumed.  what other directories should be processed?
OTHER_DIRS:= .vim/bundles bin

DIRS  :=$(addsuffix /,$(OTHER_DIRS)) ./
IGNORE:=$(addprefix %/,$(IGNORE))
FILES :=$(wildcard $(addsuffix *,$(DIRS)) $(addsuffix .*,$(DIRS)))
FILES :=$(filter-out $(IGNORE),$(FILES))
FILES :=$(patsubst ./%,%,$(FILES))
LINKS :=$(addprefix ../,$(FILES))

SUBMODULES:=$(shell grep "path = " .gitmodules)
SUBMODULES:=$(filter-out path =,$(SUBMODULES))
SUBMODULES:=$(addsuffix /.git,$(SUBMODULES))

default: ../bin
	make -L all

all: $(SUBMODULES) $(LINKS) 

##############################
######## create links ########
##############################
$(LINKS):%:$(patsubst ../%,%,$@)
	cd ../; ln -s $(PWD)/$(patsubst ../%,%,$@) $(patsubst ../%,%,$@) 
##############################

##############################
######## create dirs #########
##############################
../bin:
	mkdir -p ../bin
##############################

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
all: .oh-my-zsh/themes/poulter.zsh-theme
.oh-my-zsh/themes/poulter.zsh-theme: | $(SUBMODULES)
	cd .oh-my-zsh/themes/; \
	  ln -s ../../$(notdir $@) .

# stuff copied to bin
all: ../bin/git-when-merged
../bin/git-when-merged: | $(SUBMODULES) ../bin
	cd ../bin; \
	  ln -s $(PWD)/git/git-when-merged/bin/git-when-merged .

# stuff copied to plugin
all: .vim/plugin/autotag.vim
.vim/plugin/autotag.vim: Makefile
	wget https://raw.github.com/craigemery/dotFiles/master/vim/plugin/autotag.vim
	mv autotag.vim .vim/plugin/autotag.vim 

###############################

##########################
######## settings ########
##########################
.DELETE_ON_ERROR:
##########################
