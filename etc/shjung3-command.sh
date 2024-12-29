#!/bin/sh

MY_NAME=shjung3-command.sh

# shjung3 : for broadcom SDK compile 5.02L.05 to avoid error "addcrc: Command not found"
#PATH=$PATH:/data/knjung/brcm_project/retail_5.02/bcmdrivers/broadcom/net/wl/impl51/main/tools;

# shjung3 : for broadcom SDK compile 5.02L.07 to avoid error "addcrc: Command not found"
#PATH=$PATH:/data/shjung3/broadcom/5.02L.07/1/bcmdrivers/broadcom/net/wl/impl55/main/tools;

# shjung3 : NO needed broadcom SDK compile 5.02L.07-GA after commit hash 8ccf45213cdf959ac6a6ec06aa85adc0f0f1e59f.
#PATH=$PATH:/data/shjung3/broadcom/5.02L.07-GA/1/5.02L.07-GA/bcmdrivers/broadcom/net/wl/impl53/main/tools;

# shjung3 : for broadcom SDK compile 5.02L.07p1 to avoid error "addcrc: Command not found"
#PATH=$PATH:/home/shjung3/hp620/3/jupiter/bcmdrivers/broadcom/net/wl/impl63/main/tools;

# shjung3 : for broadcom SDK compile 5.04L.04p1 to avoid error "addcrc: Command not found"
#PATH=$PATH:/home/shjung3/pisces/1/pisces/bcmdrivers/broadcom/net/wl/impl87/main/tools;

# shjung3 : for broadcom SDK (capricorn)
PATH=/projects/hnd/tools/linux/bin:$PATH

# shjung3 : for hangul (korean)
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

################################################################
############################# Alias ############################
################################################################
alias mk100='make PROFILE=HMX_HNW100_CTC 2> compile_log'
alias mk2g='make PROFILE=HMX_HPS11_2G_AIS all 2> compile_log'
alias mk610='make PROFILE=HMX_HP610 all 2> compile_log'
alias mk620='make PROFILE=HMX_HP620_CTC all 2> compile_log'
alias mk720='make PROFILE=HMX_HP720_CATV 2> compile_log'
alias mk720s='make PROFILE=HMX_HP720_SMP 2> compile_log'
alias mk810='make PROFILE=HMX_HP810'
alias mk820='make PROFILE=HMX_HP820_CTC 2> compile_log'
alias mkpf30='make PROFILE=HMX_HPF30_SMP_LIWEST_AT 2> compile_log'
alias mks10='make PROFILE=HMX_HPS10_TH'
alias mks11='make PROFILE=HMX_HPS11_AIS all 2> compile_log'
alias mktrue='make PROFILE=HMX_HPS11R_TRUE all 2> compile_log'
alias mkwm30='make PROFILE=HMX_HNWM30_SMP_DNA 2> compile_log'
alias mk2306='make PROFILE=HMX_HNR2306_SMP 2> compile_log'
alias mk2306e='make PROFILE=HMX_HNE2306_SMP_EXT 2> compile_log'
alias mk820xgs='make PROFILE=HMX_HP820_XGS_SMP 2> compile_log'
alias mk2305='make PROFILE=HMX_HNE2305_SMP_EXT_DNA 2> compile_log'
alias vicmd='vi ~/${MY_NAME}'
alias vibashrc='vi ~/.bashrc'
alias src='cd ; . ~/.bashrc ; cd - ;'
alias up4='cd ../../../..'
alias n='nvim'
alias ta='tmux attach'
alias lg='lazygit'

#### set for shell debugging option "set -x"
complete -d cd # cd command works only directory, NO file.
export PS4='+PRINT_DEBUG#${BASH_SOURCE}#${LINENO}#${FUNCNAME[0]}: '

#### change prompt color
non='\[\033[0;0m\]'
red='\[\033[1;31m\]'
grn='\[\033[1;32m\]'
ylw='\[\033[1;33m\]'
cyn='\[\033[1;36m\]'

#PS1="\$(date)\n$cyn[$ylw\u$cyn@$ylw\h$cyn:$grn\w$cyn]$red (\$(git branch 2> /dev/null | grep \*)) \$$non "
PS1="$cyn[$ylw\u$cyn@$ylw\h$cyn:$grn\w$cyn]$red (\$(git branch 2> /dev/null | grep \*)) \$$non "





print_debug()
{
#	LOG_FILE="/tmp/shjung3-print_debug"
#	echo "PRINT_DEBUG [${MY_NAME}] : $@" > ${LOG_FILE}
#	cat ${LOG_FILE}

	echo "PRINT_DEBUG [${MY_NAME}] : $@"
}











































############################# git clone command
deprecated_exg_server=1 # exg.humax-networks.com does NOT exist, referrs https://alm.humaxdigital.com/cb/issue/2361311


####### shjung3
alias gitclone-TEST='
CMD="git clone https://shjung3.backlogtool.com/git/TEST/tutorial.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'





####### CGR
[[ ${deprecated_exg_server} -eq 0 ]] && alias gitclone-CGR_bluesheep='
CMD="git clone ssh://${USER}@exg.humax-networks.com:/git/RG/HG700/bluesheep.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'





####### REGO
[[ ${deprecated_exg_server} -eq 0 ]] && alias gitclone-REGO_HVN_BE='
CMD="git clone ssh://${USER}@exg.humax-networks.com:/git/RG/hg700/backend.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-REGO_FE_T9='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/REGO/Release-T9-frontend.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-REGO_FE_HG700='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/REGO/Release-HG700-frontend.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

#alias gitclone-REGO_FE='
#CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/HG700/frontend.git" ;
#print_debug "CMD [${CMD}]" ;
#eval ${CMD}'

[[ ${deprecated_exg_server} -eq 0 ]] && alias gitclone-REGO_FE='
CMD="git clone ssh://${USER}@exg.humax-networks.com:29418/RG/HG700/frontend" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-REGO_BE='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/hg700/rego/backend.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'





####### Intel SDK
[[ ${deprecated_exg_server} -eq 0 ]] && alias gitclone-UGW-6.1.1-beta='
CMD="git clone ssh://${USER}@exg.humax-networks.com:/git/RG/HG700/UGW-6.1.1.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

[[ ${deprecated_exg_server} -eq 0 ]] && alias gitclone-UGW-6.1.1-Rel1.4='
CMD="git clone ssh://${USER}@exg.humax-networks.com:/git/RG/HG700/UGW-6.1.1-Rel1.4.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

[[ ${deprecated_exg_server} -eq 0 ]] && alias gitclone-UGW-6.1.1-TarToSrc='
CMD="git clone ssh://${USER}@exg.humax-networks.com:/git/RG/HG700/UGW-6.1.1-TarToSrc.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

[[ ${deprecated_exg_server} -eq 0 ]] && alias gitclone-UGW-7.1-beta='
CMD="git clone ssh://${USER}@exg.humax-networks.com:/git/RG/HG700/UGW-7.1-beta.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

[[ ${deprecated_exg_server} -eq 0 ]] && alias gitclone-UGW-7.1-TarToSrc='
CMD="git clone ssh://${USER}@exg.humax-networks.com:/git/RG/HG700/UGW-7.1-beta-TarToSrc.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

[[ ${deprecated_exg_server} -eq 0 ]] && alias gitclone-UGW-7.1-GA-RC1='
CMD="git clone ssh://${USER}@exg.humax-networks.com:/git/RG/HG700/UGW-7.1-GA-RC1.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-UGW-Toolchain='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/UGW/TOOLCHAIN.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-UGW-7.1-GA-RC2='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/UGW/UGW-7.1-GA-RC2.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-UGW-7.1.1='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/UGW/UGW-7.1.1.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-UGW-7.2-ER3='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/UGW/UGW-7.2.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-UGW-7.2.1.20='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/UGW/UGW-7.2.1.20.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-UGW-7.2.4.1='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/UGW/UGW-7.2.4.1.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-UGW-7.4.1='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/UGW/UGW-7.4.1.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-UGW-7.4.2='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/UGW/UGW-7.4.2.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'





####### HUMAX Retail CPE Client
alias gitclone-hmxsvc='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/hmxDDNSClient.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-hmxsvc2='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/hmxRetailClient.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'





####### HUMAX HSP
alias gitclone-BRCM-HSP='
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/rg_hsp.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'






####### Broadcom SDK
alias gitclone-BRCM-5.02Toolchain='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/brcm/5.02_toolchain.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'
alias gitclone-BRCM-5.04Toolchain='
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/brcm/5.04_toolchain" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'
alias gitclone-BRCM-5.02L.05='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/brcm/5.02.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'
alias gitclone-BRCM-5.02L.07='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/CMS/5.02L.07.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-5.02L.07-GA='
DIR_NAME="5.02L.07-GA" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/CMS/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-5.02L.07P1='
DIR_NAME="5.02L.07p1" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/CMS/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-5.02L.07P2='
DIR_NAME="europa" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-5.04L.01='
DIR_NAME="saturn" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-5.04L.02test3='
DIR_NAME="titan" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-5.04L.02='
DIR_NAME="uranus" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'






####### Broadcom by model name
alias gitclone-BRCM-BCM4908-BCA-SDK='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/brcm/5.02.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-BCM4908-Retail-SDK='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/brcm_retail/5.02.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-P10X2V1='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/brcm/bca.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-HE220='
CMD="git clone ssh://${USER}@git.humax-networks.com:/git/RG/brcm/bca.git" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-HP620='
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/jupiter && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg jupiter/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'






####### Broadcom by git repo name
alias gitclone-BRCM-jupiter='
DIR_NAME="jupiter" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-europa='
DIR_NAME="europa" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-uranus='
DIR_NAME="uranus" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-neptune='
DIR_NAME="neptune" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-juno='
DIR_NAME="juno" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-saturn='
DIR_NAME="saturn" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-titan='
DIR_NAME="titan" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-pisces='
DIR_NAME="pisces" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/rg/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-bianca='
DIR_NAME="bianca" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-voyager='
DIR_NAME="voyager" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-capricorn='
DIR_NAME="capricorn" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'

alias gitclone-BRCM-scorpio='
DIR_NAME="scorpio" ;
CMD="git clone ssh://${USER}@git.humax-networks.com:29418/RG/dslpon/${DIR_NAME} && scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg ${DIR_NAME}/.git/hooks/" ;
print_debug "CMD [${CMD}]" ;
eval ${CMD}'



















































################################################################
########################### Functions ##########################
################################################################

################################################################ misc command

unalias l
l()
{
	CMD="ls -l -h -F $@"
	print_debug "Execute CMD [${CMD}]"
	eval ${CMD}
}

unalias ll
ll()
{
	CMD="ls -al -h -F $@"
	print_debug "Execute CMD [${CMD}]"
	eval ${CMD}
}

a() # execute a.out
{
	CMD=./a.out
	print_debug "Execute CMD [${CMD}]"
	eval ${CMD}
}

p() # patch
{
	BEFORE=$1
	AFTER=$2
	PATCH_FILE=$3

	[[ -z "${BEFORE}" ]]     && print_debug "Enter 1nd arg. CMD will be [diff -urN \"\$1\" \"\$2\" >> \$3]" && return 1
	[[ -z "${AFTER}" ]]      && print_debug "Enter 2nd arg. CMD will be [diff -urN \"\$1\" \"\$2\" >> \$3]" && return 1
	[[ -z "${PATCH_FILE}" ]] && print_debug "Enter 3nd arg. CMD will be [diff -urN \"\$1\" \"\$2\" >> \$3]" && return 1

	CMD="diff -urN ${BEFORE} ${AFTER} >> ${PATCH_FILE}"
	print_debug "Execute CMD [${CMD}]"
	sleep 1;
	echo
	echo
	eval ${CMD}
	echo
	echo
}

g() # grep such as ag, rg
{
	STRING=$1
	TARGET=$2
	[[ -z "${STRING}" ]] && print_debug "Enter arg of grep command" && return 1

############### use rg
#	CMD="rg -n --sort-files -i \"${STRING}\" ${TARGET} 2> /dev/null" # it's slowly
	CMD="rg -n \"${STRING}\" ${TARGET} 2> /dev/null"
############### use ag
#	CMD="ag \"${STRING}\" ${TARGET}"
############### use grep
#	CMD="grep -rni \"${STRING}\" ${TARGET} * 2> /dev/null"

	print_debug "Execute CMD [${CMD}]"
	echo
	echo
	eval ${CMD}
	echo
	echo
}

g1() # ag with option "-0" : file name 
{
# ex. 
#	before
#		ssk/lanhosts.c
#		52:#include "cms_core.h"
#	after
#		ssk/lanhosts.c52:#include "cms_core.h"

#	CMD="ag -0 $@"
	CMD="g -0 $@"
	print_debug "Execute CMD [${CMD}]"
	echo
	echo
	eval ${CMD}
	echo
	echo
}

g5() # ag with option of after/before line 5
{
#	CMD="ag -A5 -B5 $@"
	CMD="g -A5 -B5 $@"
	print_debug "Execute CMD [${CMD}]"
	echo
	echo
	eval ${CMD}
	echo
	echo
}

g1() # grep to ~/1.txt
{
	STRING=$1
	DIR=$2
	TARGET="~/1.txt"

	[[ -z "${STRING}" ]] && print_debug "Enter 2nd arg. CMD will be [grep --line-number \"\$1\" > \$2 2> /dev/null]" && return 1
	[[ -z "${DIR}" ]] && DIR=.
	CMD="grep -r --line-number \"${STRING}\" ${DIR} 2> /dev/null > ${TARGET}"
	print_debug "Execute CMD [${CMD}]"
	echo
	echo
	eval ${CMD}
	echo
	echo
}

g2() # grep to ~/2.txt
{
	STRING=$1
	DIR=$2
	TARGET="~/2.txt"

	[[ -z "${STRING}" ]] && print_debug "Enter 2nd arg. CMD will be [grep --line-number \"\$1\" > \$2 2> /dev/null]" && return 1
	[[ -z "${DIR}" ]] && DIR=.
	CMD="grep -r --line-number \"${STRING}\" ${DIR} 2> /dev/null > ${TARGET}"
	print_debug "Execute CMD [${CMD}]"
	echo
	echo
	eval ${CMD}
	echo
	echo
}

s1() # save result to ~/1.txt. ex. r1 cat /etc/resolv.conf
{
	CMD="$@ > ~/1.txt"
	print_debug "Execute CMD [${CMD}]"
	echo
	echo
	eval ${CMD}
	echo
	echo
}

s2() # save result to ~/2.txt
{
	CMD="$@ > ~/2.txt"
	print_debug "Execute CMD [${CMD}]"
	echo
	echo
	eval ${CMD}
	echo
	echo
}

s3() # save result to ~/3.txt
{
	CMD="$@ > ~/3.txt"
	print_debug "Execute CMD [${CMD}]"
	echo
	echo
	eval ${CMD}
	echo
	echo
}

f() # find
{
	if [ -z "$1" ]; then
		CMD="find 2> /dev/null | sort -n"
	else
		if [[ $1 == *"*"* ]]; then # change "*" --> ".*" for grep arguement
			GREP_ARG=`echo $1 | sed "s+*+.*+g"`
		else
			GREP_ARG=$1
		fi
		CMD="find -name \"$1\" 2> /dev/null | sort -n | grep -E \"${GREP_ARG}\""
	fi

	[[ -n "$2" ]] && print_debug "This command can recevie a one arg, otherwise use \"find\" command." && return 1

	print_debug "Execute CMD [${CMD}]"
#	sleep 1;
	echo
	echo
	eval ${CMD}
	echo
	echo
}

z() # copy the text to root directoy for easy check on Windows
{
	[[ -z "$2" ]] && print_debug "Enter 2nd arg. CMD will be [cat \$1 > ~/\$2]" && return 1
	CMD="cat $1 > ~/$2"
	print_debug "Execute CMD [${CMD}]"
#	sleep 1;
	echo
	echo
	eval ${CMD}
	echo
	echo
}

c() # gcc
{
	[[ -z "$1" ]] && print_debug "Enter 2nd arg. CMD will be [gcc \$1 && ./a.out]" && return 1

	FILE_NAME=$1
	shift

	CMD="gcc ${FILE_NAME} $@ && ./a.out"
	print_debug "Execute CMD [${CMD}]"
#	sleep 1;
	echo
	echo
	eval ${CMD}
	echo
	echo
}

d() # disk usage check
{
	DIR=$1
	
	if [ -n "${DIR}" ]; then
		CMD="du -h --max-depth=0 ./${DIR} 2> /dev/null | sort -hr"
	else
		CMD="du -h --max-depth=1 ./ 2> /dev/null | sort -hr"
	fi
	print_debug "Execute CMD [${CMD}]"
#	sleep 1;
	echo
	echo
	eval ${CMD}
	echo
	echo

}

s() # change string by sed
{
	string_before=$1
	string_after=$2
	delimiter="+"
	shift
	shift
	dir=$@

	[[ -z ${string_before} ]] && print_debug "Enter 1st arg (= string before changed)." && return 1
	[[ -z ${string_after} ]] && print_debug "Enter 2nd arg (= string after changed)." && return 1

	if [ -z "${dir}" ]; then
		echo -e "\t #### Do you want to change [${string_before}] to [${string_after}] on now directory? [Y/n] "
	else
		echo -e "\t #### Do you want to change [${string_before}] to [${string_after}] on directory [${dir}]? [Y/n] "
	fi	
	read -r answer
	
	[ "${answer}" = "N" -o "${answer}" = "n" ] && return 0

	CMD="rg -l \"${string_before}\" ./${dir}"
#	CMD="grep -rl \"${string_before}\" ./${dir}"
	print_debug "Command is [${CMD}]"
	files=`eval ${CMD}`
	
	if [ -z "${files}" ]; then
		print_debug "can NOT find the string [${string_before}] in the directory. "
		return 0
	fi	
	
	CMD="sed -i 's${delimiter}${string_before}${delimiter}${string_after}${delimiter}g' ${files}"

	print_debug "Command is [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}

sf() # forced (= NO ask) change string by sed
{
    string_before=$1
    string_after=$2
    delimiter="+"
    shift
    shift
    dir=$@

    [[ -z ${string_before} ]] && print_debug "Enter 1st arg (= string before changed)." && return 1
    [[ -z ${string_after} ]] && print_debug "Enter 2nd arg (= string after changed)." && return 1

    print_debug "Command is [grep -rl \"${string_before}\" ./${dir}]"
    files=`grep -rl "${string_before}" ./${dir}`

    if [ -z "${files}" ]; then
        print_debug "can NOT find the string [${string_before}] in the directory. "
        return 0
    fi

    CMD="sed -i 's${delimiter}${string_before}${delimiter}${string_after}${delimiter}g' ${files}"

    print_debug "Command is [${CMD}]"
    sleep 1
    echo
    echo
    eval ${CMD}
    echo
    echo
}

sd() # delete line by sed
{
	string_before=$1
	shift
	dir=$@

	if [ -z "${dir}" ]; then
		echo -e "\t #### Do you want to remove [${string_before}] on now directory? [Y/n] "
	else
		echo -e "\t #### Do you want to remove [${string_before}] on directory [${dir}]? [Y/n] "
	fi	
	read -r answer
	
	[ "${answer}" = "N" -o "${answer}" = "n" ] && return 0

	files=`grep -rl "${string_before}" ./${dir}`
	
	if [ -z "${files}" ]; then
		print_debug "can NOT find the string [${string_before}] in the directory. "
		return 0
	fi	
	
	CMD="sed -i '/${string_before}/d' ${files}"

	print_debug "Command is [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}

cpdir() # copy to other directory
{
	TMP_FILE=.cpdir.tmp
	TARGET_DIR="PRINT_DEBUG"

	[[ -z "$1" ]] && print_debug "Enter file names." && return 1

	echo
	echo -e "\t #### Enter the target directory. default:[${TARGET_DIR}] ex. 1, 2, 3, t9, t9x, PRINT_DEBUG"
	read -r answer
	[[ -n "${answer}" ]] && TARGET_DIR="${answer}"

	if [ "${TARGET_DIR}" == "PRINT_DEBUG" ]; then
		GIT_DIR=`pwd | cut -d '/' -f 5` # ex. 1-HMX_HPS11_TH_RELEASE-hps11-mg
		CHECK_DIR="../../${TARGET_DIR}/${GIT_DIR}"

		if [ -d ${CHECK_DIR} ]; then
			echo
			print_debug "The taget directory [${CHECK_DIR}] is already exist."
			echo -e "\t #### Do you want to remove and then create the directory [${CHECK_DIR}] ? [Y/n]"
			read -r answer
			[ "${answer}" = "N" -o "${answer}" = "n" ] && return 0
			rm -fr ${CHECK_DIR}
			mkdir -p ${CHECK_DIR}
		fi

	else # NOT PRINT_DEBUG
		GIT_DIR=`pwd | sed 's/.*\///g'` # ex. europa
		CHECK_DIR="../../${TARGET_DIR}/${GIT_DIR}"

		if [ ! -d ${CHECK_DIR} ]; then
			echo
			print_debug "The taget directory [${CHECK_DIR}] is NOT exist."
			echo
			return 0
		fi
	fi


	if [ "${TARGET_DIR}" == "PRINT_DEBUG" ]; then
		GIT_DIR=`pwd | cut -d '/' -f 5` # ex. 1-HMX_HPS11_TH_RELEASE-hps11-mg
	fi


	echo "TARGET_DIR [${TARGET_DIR}]"     # 3
	echo "GIT_DIR [${GIT_DIR}]"           # neptune
	CHECK_DIR="/${TARGET_DIR}/${GIT_DIR}"
	echo "CHECK_DIR [${CHECK_DIR}]"       # /4/neptune
	NOW_DIR="`pwd`/"
	if [[ ${NOW_DIR} == *${CHECK_DIR}* ]]; then
		print_debug "The target directory is same now directory."
		return 1
	fi

	echo $@ > ${TMP_FILE}
	entries=`cat ${TMP_FILE}`
	echo "entries [${entries}]"                            # entries [build/Makefile]
	for entry in ${entries}
	do
		FILE_NAME=`echo ${entry} | sed 's/.*\///g'`
		echo "FILE_NAME [${FILE_NAME}]"                # FILE_NAME [Makefile]
		echo "entry/FILE_NAME [${entry/${FILE_NAME}}]" # entry/FILE_NAME [build/]
		CMD="mkdir -p ../../${TARGET_DIR}/${GIT_DIR}/${entry/${FILE_NAME}}"
		print_debug "Command is [${CMD}]"
		eval ${CMD}
	
		CMD="yes | cp -fr ${entry} ../../${TARGET_DIR}/${GIT_DIR}/${entry}"
		print_debug "Command is [${CMD}]"
		eval ${CMD}
		echo
		echo
	done
	
	rm -fr ${TMP_FILE}
}

scpdir() # copy to other network directory
{
	CUR_DIR=`pwd`
	TMP_FILE=".scpdir.tmp"
	SERVER_IP="10.250.21.131"
	TARGET_ROOT_DIR="shjung3@${SERVER_IP}:"
	IS_REVERSE=

	[[ -z "$1" ]] && print_debug "Enter file names." && return 1

	for arg_entry in $@
	do
		case "${arg_entry}" in
			-r | --reverse)
				shift
				IS_REVERSE=1
				echo -e "\n\t #### IS_REVERSE is enabled"
				echo
			;;
		esac
	done

	echo
	echo -e "\t #### Enter the target directory. [default : ${CUR_DIR/\/home\/shjung3\/}]" # #### Enter the target directory. [default : europa/1/europa]
	read -r answer
	[[ -z "${answer}" ]] && TARGET_ROOT_DIR="${TARGET_ROOT_DIR}${CUR_DIR}"
	[[ -n "${answer}" ]] && TARGET_ROOT_DIR="${TARGET_ROOT_DIR}/home/shjung3/${answer}"

	echo -e "\t #### the TARGET_ROOT_DIR [${TARGET_ROOT_DIR}]. can NOT undo it, it's right? [Y/n]"
	read -r answer
	[ "${answer}" = "N" -o "${answer}" = "n" ] && return 0

	echo $@ > ${TMP_FILE}
	entries=`cat ${TMP_FILE}`
#	echo "entries [${entries}]"                        # entries         [build/Makefile]
	for entry in ${entries}
	do
		FILE_NAME=`echo ${entry} | sed 's/.*\///g'`
#		echo "FILE_NAME       [${FILE_NAME}]"          # FILE_NAME       [Makefile]
#		echo "entry/FILE_NAME [${entry/${FILE_NAME}}]" # entry/FILE_NAME [build/]
		if [ -z "${IS_REVERSE}" ]; then
			TARGET="${TARGET_ROOT_DIR}/${entry/${FILE_NAME}}"
			CMD="scp -r ${entry} ${TARGET}"
		else
			TARGET="${TARGET_ROOT_DIR}/${entry}"
			CMD="scp -r ${TARGET} ${entry}"
		fi
		print_debug "Command is [${CMD}]"
		eval ${CMD}
		echo
		echo
	done

	rm -fr ${TMP_FILE}
}

dump() # create dummy file
{
	SIZE="100M"

	echo -e "\t #### Enter the dummy file size. default:[${SIZE}] ex. 1G 1M"
	read -r answer
	[[ -n "${answer}" ]] && SIZE="${answer}"

	FILE_NAME="${SIZE}B.bin"
	CMD="fallocate -l ${SIZE} ${FILE_NAME}"
	print_debug "Command is [${CMD}]"
	sleep 1
	eval ${CMD}
	echo
	echo

	echo "created file [${FILE_NAME}]"
}

slist() # show symbolic files
{
	SHOW_ALL=0
# ex.
#	lrwxrwxrwx  1 shjung3 shjung3       2 Dec 29 08:59 10-HMX_HPS11_SMP_RT-pocs -> 10/
#	lrwxrwxrwx  1 shjung3 shjung3       2 Jan  3 19:23 11-HMX_AX54_SMP_RT_OVS-pocs -> 11/
#	lrwxrwxrwx  1 shjung3 shjung3       2 Jan 10 16:25 12-HMX_HP830_SMP_RT-pocs -> 12/
#	lrwxrwxrwx  1 shjung3 shjung3       2 Jan 21 14:39 13-HMX_HP620_AIS-hps11-mg -> 13/
#	lrwxrwxrwx  1 shjung3 shjung3       2 Jan 24 17:14 14-HMX_P10X2V1-sonu -> 14/
#	lrwxrwxrwx  1 shjung3 shjung3       2 Jan 27 16:13 15-HMX_EAX78_EXT_ATT-pocs -> 15/
#	lrwxrwxrwx  1 shjung3 shjung3       2 Feb  4 18:38 16-HMX_HP620_SMP_JP-pocs -> 16/
#	lrwxrwxrwx  1 shjung3 shjung3       1 Dec 27 10:40 1-HMX_HPS11R_TRUE-bringup -> 1/
#	lrwxrwxrwx  1 shjung3 shjung3       1 Feb  8 11:12 2-HMX_HPS11_AIS_UNIV-hps11-mg -> 2/
#	lrwxrwxrwx  1 shjung3 shjung3       1 Dec 27 10:40 3-HMX_HPS11_AIS-hps11-mg -> 3/
#	lrwxrwxrwx  1 shjung3 shjung3       1 Dec 27 10:40 4-HMX_HP620_CTC-pocs -> 4/
#	lrwxrwxrwx  1 shjung3 shjung3       1 Dec 27 10:40 5-HMX_HPS11R_TRUE-hps11-mg -> 5/
#	lrwxrwxrwx  1 shjung3 shjung3       1 Dec 27 10:40 6-BRCM_ORIG_SDK-master -> 6/
#	lrwxrwxrwx  1 shjung3 shjung3       1 Dec 27 10:40 7-HMX_AX54_CTC_RT-pocs -> 7/
#	lrwxrwxrwx  1 shjung3 shjung3       1 Dec 27 10:40 8-HMX_HP620_SMP-pocs -> 8/
#	lrwxrwxrwx  1 shjung3 shjung3       1 Dec 27 10:40 999-HMX_HPS11R_TRUE-hps11 -> 2/
#	lrwxrwxrwx  1 shjung3 shjung3       1 Dec 27 10:40 9-HMX_AX54_SMP_RT-pocs -> 9/

	echo -e "\t #### show all? [y/N]"
	read -r answer
	[ "${answer}" = "Y" -o "${answer}" = "y" ] && SHOW_ALL=1

	if [ ${SHOW_ALL} -eq 1 ]; then
		CMD="ll | grep '\->' | awk '{print \$9}'"
		print_debug "Execute CMD [${CMD}]"
		eval ${CMD}
	else
		# only show if clonse directory exist
		TMP_FILE=".shjung3-directories.txt"
		CMD="find -maxdepth 2 -mindepth 2 -type d | grep -v PRINT_DEBUG | cut -d '/' -f 2  | sort -n > ${TMP_FILE}"
		print_debug "Execute CMD [${CMD}]"
		eval ${CMD}

		entries=`cat ${TMP_FILE}`
		for entry in ${entries}
		do
			CMD="ll | grep '\-> ${entry}/$' | awk '{print \$9}'"
#			print_debug "Execute CMD [${CMD}]"
			eval ${CMD}
		done
		
		rm -fr ${TMP_FILE}
	fi
}

gdb2() # GDB for broadcom SDK CMS
{
	answer="$1"
	shift
	while [ -z "${answer}" ]; do
		echo -e "\t #### Enter core dump file name [ex. core.hmxols.8043.83.gz]"
		read -r answer
	done
	COREDUMP_COMP_FILE_NAME="${answer}"
	COREDUMP_FILE_NAME=${answer/\.gz}
	COREDUMP_BIN__NAME=`echo ${answer} | cut -d '.' -f 2`

	echo "// COREDUMP_FILE_NAME [${COREDUMP_FILE_NAME}]"
	echo "// COREDUMP_BIN__NAME [${COREDUMP_BIN__NAME}]"

	CMD="gzip -d -k ${COREDUMP_COMP_FILE_NAME}" # -k : keep input file, do NOT delete the file
	print_debug "Execute CMD [${CMD}]"
	eval ${CMD} || return 0


	answer=""
	while [ -z "${answer}" ]; do
		echo -e "\t #### Enter git repo direcoty [ex. neptune/2]"
		read -r answer
	done
	BUILD_PROFILE=`ls -l ${answer}-* | grep '\->' | awk '{print \$9}' | cut -d "-" -f 2`
	ROOT_DIR=`echo ${answer} | cut -d '/' -f 1`
	SHJUNG_DIR="${answer}/${ROOT_DIR}"

	if [[ ${ROOT_DIR} == "jupiter" ]] || [[ ${ROOT_DIR} == "europa" ]]; then
		GDB_BINARY=/opt/toolchains//crosstools-arm-gcc-5.5-linux-4.1-glibc-2.26-binutils-2.28.1/usr/bin/arm-buildroot-linux-gnueabi-gdb
	elif [[ ${ROOT_DIR} == "neptune" ]] || [[ ${ROOT_DIR} == "pisces" ]] || [[ ${ROOT_DIR} == "capricorn" ]]; then
		GDB_BINARY=/opt/toolchains//crosstools-arm_softfp-gcc-10.3-linux-4.19-glibc-2.32-binutils-2.36.1/usr/bin/arm-buildroot-linux-gnueabi-gdb
	fi

	echo "// BUILD_PROFILE [${BUILD_PROFILE}]"
	echo "// BROOT_DIR [${ROOT_DIR}]"
	echo "// SHJUNG_DIR [${SHJUNG_DIR}]"
	echo "// GDB_BINARY [${GDB_BINARY}]"

	[[ -z "${GDB_BINARY}" ]] && return 0

	DIR_FS=/home/shjung3/${SHJUNG_DIR}/targets/${BUILD_PROFILE}/fs/

	echo -e "\t #### remove legacy file [${DIR_FS/fs}fs.install/${COREDUMP_BIN__NAME}]"
	rm ${DIR_FS/fs}fs.install/${COREDUMP_BIN__NAME} 2> /dev/null

	while true ; do
#		CMD="find ${DIR_FS} -name ${COREDUMP_BIN__NAME} -type f,l"      # file and symbolic link
		CMD="find ${DIR_FS} -name ${COREDUMP_BIN__NAME} -type f"        # file
		echo -e "\t #### try to find the binary file by using [${CMD}]"
#		FILE_BIN=`find ${DIR_FS} -name ${COREDUMP_BIN__NAME} -type f,l` # file and symbolic link
		FILE_BIN=`find ${DIR_FS} -name ${COREDUMP_BIN__NAME} -type f`   # file

		if [ -n "${FILE_BIN}" ]; then
			echo -e "\t #### found the [${COREDUMP_BIN__NAME}] on [${DIR_BIN}]"
			DIR_BIN=${FILE_BIN/${COREDUMP_BIN__NAME}}
			break
		else
			echo -e "\t #### could NOT find the [${COREDUMP_BIN__NAME}] on [${DIR_FS}]"

			answer=""
			while [ -z "${answer}" ]; do
				echo -e "\t      Enter the binary name, NOT symbolic link file directory of location (ex. ${COREDUMP_BIN__NAME})"
				read -r answer
			done
			COREDUMP_BIN__NAME=${answer}
		fi
	done

	DIR_FS_INSTALL=${DIR_FS/fs}fs.install/

#	if [[ ${COREDUMP_BIN__NAME} == "hmxols" ]]; then
		CMD="ln -sf ${FILE_BIN} ${DIR_FS_INSTALL} && cp ${COREDUMP_FILE_NAME} ${DIR_FS_INSTALL} && cd ${DIR_FS_INSTALL}"
		print_debug "Execute CMD [${CMD}]"
		eval ${CMD} || return 0
#	else
#		CMD="cp ${COREDUMP_FILE_NAME} ${DIR_BIN} && cd ${DIR_BIN}"
#		print_debug "Execute CMD [${CMD}]"
#		eval ${CMD} || return 0
#	fi

	echo
	echo
	echo
	echo
	echo
	echo
	echo
	echo "########## copy & paste below commands ##########"
	echo "info share"
	echo "set sysroot ${DIR_FS_INSTALL}"
	echo "info share"
	echo "bt"
	echo "info locals"
	echo "info args"
	echo "// frame #"
	echo "bt f     <========= this command is best !!!!!!!"
	echo "l        <========= this command is best !!!!!!!"
	echo "up"
	echo "l"
	echo "down"
	echo "l"
	echo "########## copy & paste above commands ##########"
	echo
	echo

	CMD="${GDB_BINARY} ${COREDUMP_BIN__NAME} ${COREDUMP_FILE_NAME}"
	print_debug "Execute CMD [${CMD}]"
	eval ${CMD} || return 0
}

er() # show error log
{
#	CMD='rg -A 5 "make\[.* Error " bm*' # show failed directory
	CMD='ag -A 5 "make\[.* Error " bm*' # show failed directory
	print_debug "Execute CMD [${CMD}]"
	eval ${CMD}

#	CMD='rg "error:" bm*'               # show error log
	CMD='ag "error:" bm*'               # show error log
	print_debug "Execute CMD [${CMD}]"
	eval ${CMD}
}

tts() # tab to space
{
	BEFORE=$1

	[[ -z ${BEFORE} ]] && print_debug "Enter 1st arg (= tab file before changed)." && return 1
	echo -e "\t #### Do you want to change tab to space 4 of the file [${BEFORE}] ? [Y/n]"
	read -r answer
	[ "${answer}" = "N" -o "${answer}" = "n" ] && return 0

	CMD="cp ${BEFORE} ${BEFORE}.bak && expand -i -t 4 ${BEFORE} > ${BEFORE}.bak"
	print_debug "Execute CMD [${CMD}]"
	eval ${CMD} || return 1

	CMD="mv ${BEFORE}.bak ${BEFORE}"
	print_debug "Execute CMD [${CMD}]"
	eval ${CMD} || return 1
}








################################################################ git command
get_branch()
{
	git branch | grep "\*" | cut -d ' ' -f 2
#	repo info . 2> /dev/null | grep "^Manifest revision:" | awk '{print $3}'
}


get_profile()
{
# if pwd is "pisces/3-HMX_HAF60_SMP-pocs/pisces"
# return "HMX_HAF60_SMP"
	pwd | cut -d "-" -f 2
}


gl() # git log
{
	print_debug "options are [oneline] [files] [all]"
	CMD="git log --graph --decorate"

	for arg_entry in $@
	do
		case "${arg_entry}" in
			shjung3)
				CMD="${CMD} --author=\"shjung3@humax-networks.com\""
			;;
			oneline)
				CMD="${CMD} --pretty=oneline"
			;;
			short)
				CMD="${CMD} --abbrev-commit"
			;;
			files)
				CMD="${CMD} --name-status"
			;;
			latest) # one latest commit
				CMD="${CMD} HEAD^..HEAD"
			;;
			all) # all branch's
				CMD="${CMD} --all"
			;;
			*)
				CMD="${CMD} ${arg_entry}"
			;;
		esac
	done

	print_debug "Execute CMD [${CMD}]"
#	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}



ga() # git add
{
	CMD="git add"
	for arg_entry in $@
	do
		case "${arg_entry}" in
			*)
				CMD="${CMD} ${arg_entry}"
			;;
		esac
	done

	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}



gc() # git checkout
{
	CMD="git checkout"
	for arg_entry in $@
	do
		case "${arg_entry}" in
			*)
				CMD="${CMD} ${arg_entry}"
			;;
		esac
	done

	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}



gr() # git reset
{
	CMD="git reset"

	for arg_entry in $@
	do
		case "${arg_entry}" in
			-a | --all | -f | --force)
				CMD="
mv bm-*.log ../ ;
rm -fr .gitignore ;
rm -fr userspace/humax/apps/rego/frontend/ ; git checkout userspace/humax/apps/rego/frontend/ ;
rm -fr userspace/humax/apps/wifi_agent/ ; git checkout userspace/humax/apps/wifi_agent/ ;
rm -fr userspace/public/libs/cjose/ ; git checkout userspace/public/libs/cjose/ ;
rm -fr bcasdk/ build-brcm*/ ;
rm -fr rdkb/ ; git checkout rdkb/ ;
rm -fr .repo/ ; git checkout .repo/ ;
git clean -dfx > /dev/null ;
git checkout . ;
ln -s ../../*.sh . ;
rm auto_git_clone.sh ;
rm -fr .gitignore ;
rm \*.sh ;
git status ;
"
				echo -e "\t #### [CAUTION] Do you want git clean all ? really ???? [Y/n]"
				read -r answer
				echo
				echo
				if [ "${anser}" != "N" ] && [ "${answer}" != "n" ]; then
					print_debug "Execute CMD [${CMD}]"
					sleep 1
					echo
					echo
					eval ${CMD}
					echo
					echo
				fi
				return 0
			;;
			*)
				CMD="${CMD} ${arg_entry}"
			;;
		esac
	done

	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}



gd() # git diff
{
	CMD="git diff"
	print_debug "options are [stage (wit commit)|s] [rego] [cms_core]"

	for arg_entry in $@
	do
		case "${arg_entry}" in
			stage|s)
				CMD="${CMD} --staged"
			;;

			unstage|us)
				TMP_FILE=".shjung3.$0"
				gs us | grep -v PRINT_DEBUG | grep -v .gitignore > ${TMP_FILE}
				entries=`cat ${TMP_FILE}`
				echo "entries [${entries}]"
				for entry in ${entries}
				do
					CMD="${CMD} ${entry}"
				done
			;;

			rego)	
				CMD="${CMD} userspace/humax/apps/rego"
			;;

			cms_core)	
				CMD="${CMD} userspace/private/libs/cms_core"
			;;

			*)
				CMD="${CMD} ${arg_entry}"
			;;
		esac
	done

	print_debug "Execute CMD [${CMD}]"
#	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}



gs() # git status
{
	ALL=0
	CMD="git status -uno"
	print_debug "options are [untrack|ut] [unstage|us] [stage|s] [rego] [cms_core] [all]"

	for arg_entry in $@
	do
		case "${arg_entry}" in
			untrack | ut)
				CMD="git ls-files --others --exclude-standard"
			;;
			unstage | us)
				CMD="git diff --name-only"
			;;
			stage | s)
				ALL=1
				CMD="git diff --name-only --cached"
			;;
			rego)
				CMD="${CMD} | grep userspace/humax/apps/rego"
			;;
			cms_core)
				CMD="${CMD} | grep userspace/private/libs/cms_core"
			;;
			all)
				ALL=1
			;;
			*)
				CMD="${CMD} ${arg_entry}"
			;;
		esac
	done
	
	# exclude auto generated files
	if [ "${ALL}" != "1" ]; then

		CMD="${CMD} | grep -v '\
.repo/*\|\
bcmdrivers/broadcom/net/wl/*/\|\
targets/fs.src/bin/hmx_eax78_led.sh\|\
hostTools/xz-.*/config\|\
kernel/linux-.*/autoregs_d11revs_dbg.txt\|\
kernel/linux-.*/wlconf.h\|\
targets/cfe/\|\
userspace/gpl/apps/mtd/mtd-utils-2.0.2/configure\|\
userspace/private/apps/httpd/minimized_webs.tar\|\
userspace/public/libs/treetable/minimized_webs.tar\|\
userspace/private/apps/wlan/wlcsm_dm\|\
data-model/merge-igd.d/4820-tr181-delete-net.txt\|\
userspace/private/libs/omcisdk/core/data-model/merge-igd.d/2100-gpon.txt\|\
userspace/private/libs/omcisdk/core/data-model/HMX_DM_BUILD_LOG.txt\|\
userspace/private/libs/mdk/mdk-2.8.0.tar.gz\|\
userspace/humax/apps/hmxsense/hmxsense'"
	fi

	print_debug "Execute CMD [${CMD}]"
#	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}



wgp() # while git pull
{
	PERIOD_MIN=10

	[[ -n "$1" ]] && PERIOD_MIN=$1

	PERIOD=`expr ${PERIOD_MIN} \* 60`
	NOW_DIR=`pwd`
	GIT_PULL_LOG_FILE=".git-pull"

	CMD="while [ 1 ] ; do
git pull > ${GIT_PULL_LOG_FILE} ;
echo \"${NOW_DIR} ## PERIOD : [${PERIOD}] sec ## \`cat ${GIT_PULL_LOG_FILE}\`\" ;
sleep ${PERIOD} ;
done"
	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
}


gp() # git pull & push
{
	echo -e "\t #### Really do you want \"git push\" instead of \"gerrit push\" ??????????????????????????? [Y/n]"
	git remote --v | grep ":"
	read -r answer
	[ "${answer}" = "N" -o "${answer}" = "n" ] && return 0
	echo

	print_debug "Check commit message !!!"
	echo
	echo
	cat cm
	echo
	echo

	print_debug "These files will be pushed !!!"
	CMD="git diff --name-only --cached"
	print_debug "Execute CMD [${CMD}]"
#	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo

	print_debug "Check updates on git repository."
	CMD="git pull"
	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo

	echo -e "\t #### Do you want to commit? [Y/n]"
	read -r answer
	[ "${answer}" = "N" -o "${answer}" = "n" ] && return 0
	echo

	CMD="git commit -F cm && git push"
	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}


grpush() # gerrit git push
{
	branch=`get_branch`
	reviewer=""

#	echo -e "\t #### Enter branch (HEAD:refs/for/XXXX) ? [default:${branch}]"
#	read -r answer
#	[[ -n "${answer}" ]] && branch="${answer}"

	echo -e "\t #### Do you want [DRAFT] commit? [Y/n]"
	read -r answer
	if [ "${answer}" = "N" -o "${answer}" = "n" ]; then
		CMD="git push origin HEAD:refs/for/${branch}"
	else
		CMD="git push origin HEAD:refs/drafts/${branch}"
	fi

	print_debug "preapred CMD [${CMD}]"

#	while [ 1 ]; # loop if XXX@humax-networks.com account is invalid
#	do
#		while [ 1 ]; # loop if answer is NULL
#		do
#			echo -e "\t #### Enter reviewer (XXXX@humax-networks.com) ? ex. hlee, skkim [default : shjung3]"
#			read -r answer
#			[[ -z "${answer}" ]] && answer="shjung3"
#			break
#		done
#		reviewer="${answer}@humax-networks.com"
#		reviewer="shjung3@humax-networks.com"

#		CMD2="${CMD} --receive-pack='git receive-pack --reviewer ${reviewer}'"
		CMD2="${CMD} --receive-pack='git receive-pack'"

		print_debug "Execute CMD2 [${CMD2}]"
		sleep 1
		echo
		echo
#		eval ${CMD2} && break
		eval ${CMD2}
		echo
		echo
#	done
}



grp() # gerrit git pull & push
{
	print_debug "Check updates on git repository."
	CMD="git pull"
	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo


	print_debug "Check [commit-msg] file for add \"Change-Id\" in commit message..."
	if [ ! -e .git/hooks/commit-msg ]; then
		CMD="scp -p -P 29418 ${USER}@git.humax-networks.com:hooks/commit-msg .git/hooks/"
		print_debug "There is NO commit-msg file, Execute CMD [${CMD}]"
		sleep 1
		echo
		echo
		eval ${CMD}
		echo
		echo
	fi


	print_debug "below commit message will be pushed"
	echo
	echo
	cat cm
	echo
	echo


	print_debug "below files will be pushed"
	CMD="git diff --name-only --cached"
	print_debug "Execute CMD [${CMD}]"
#	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo


	echo -e "\t #### Do you want to commit? [Y/n]"
	read -r answer
	if [ "${answer}" = "N" -o "${answer}" = "n" ]; then
		CMD="grpush"
	else
		CMD="git commit -F cm && grpush"
	fi
	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}



gitpull() # git pull with rebase, stash
{
	# check git version
	GIT_VERSION_MAJOR=`git --version | awk '{print $3}' | cut -d '.' -f 1`
	GIT_VERSION_MINOR=`git --version | awk '{print $3}' | cut -d '.' -f 2`

	if [ ${GIT_VERSION_MAJOR} -ge 2 ] && [ ${GIT_VERSION_MINOR} -ge 17 ]; then
		CMD="git pull --rebase --autostash && gs all"
	else
		CMD="git stash && git pull --rebase && git stash pop > /dev/null && gs all"
	fi

	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}



gitstash_legacy() # git stash --> git pull --> git stash pop
{
	TIME=`date +%Y%m%d-%H%M%S`
	if [ -z $1 ]; then
		print_debug "stashing all files"
		CMD="git stash && git pull --rebase && git stash pop"
	else
		CMD="git stash push -m ${TIME}"
		for arg_entry in $@
		do
			case "${arg_entry}" in
				*)
					CMD="${CMD} ${arg_entry}"
				;;
			esac
		done
	
#		CMD="${CMD} && git pull && git stash pop 1> /dev/null && git stash drop"
	fi

	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}



get_my_stash_number()
{
	CMD="git stash list"
	print_debug "show all stash with CMD [${CMD}]"
	eval ${CMD}
	echo
	echo

	CMD="git stash list | grep -m 1 `get_branch` | cut -d '{' -f 2 | cut -d '}' -f 1"
	print_debug "get my branch's first stash with CMD [${CMD}]"
	eval ${CMD}
	echo
	echo
}

# gitstash     (= git stash save)
# gitstash pop (= git stash pop)
#
gitstash()
{
	CURRENT_TIME=`date +%Y%m%d-%H%M%S`
	BRANCH=`get_branch`

	# check git version
	GIT_VERSION_MAJOR=`git --version | awk '{print $3}' | cut -d '.' -f 1`
	GIT_VERSION_MINOR=`git --version | awk '{print $3}' | cut -d '.' -f 2`

	if [ ${GIT_VERSION_MAJOR} -ge 2 ] && [ ${GIT_VERSION_MINOR} -ge 17 ]; then
		CMD="git stash save ${BRANCH}-${CURRENT_TIME}"    # Virtual Machine git version : 2.17.1
	else
		CMD="git stash push -m ${BRANCH}-${CURRENT_TIME}" # Build server git version : 2.7.1
	fi

	echo "$1"

	if [ -n "$1" ]; then
		CMD="git stash push -m ${BRANCH}-${CURRENT_TIME}-SpecificFiles"
		for arg_entry in $@
		do
			case "${arg_entry}" in
				*)
					CMD="${CMD} ${arg_entry}"
				;;
			esac
		done
	fi

	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}



gitcommit() # git stash + git pull + git stash pop
{
	if [ -n "$1" ]; then
		CMD="gd $@"
		print_debug "Execute CMD [${CMD}]"
		echo
		echo
		eval ${CMD}
		echo
		echo

		CMD="gl --graph HEAD^..HEAD"
		print_debug "Execute CMD [${CMD}]"
		eval ${CMD}

		echo -e "\t #### Do you want to commit? [Y/n]"
		read -r answer
		[ "${answer}" = "N" -o "${answer}" = "n" ] && return 0

		CMD="ga $@"
		print_debug "Execute CMD [${CMD}]"
		sleep 1
		echo
		echo
		eval ${CMD}
		echo
		echo
	else
		CMD="gd s"
		print_debug "Execute CMD [${CMD}]"
		eval ${CMD}
		echo

		CMD="gl --graph HEAD^..HEAD"
		print_debug "Execute CMD [${CMD}]"
		eval ${CMD}

		echo -e "\t #### Do you want to commit? [Y/n]"
		read -r answer
		[ "${answer}" = "N" -o "${answer}" = "n" ] && return 0
	fi

	CMD="git commit --amend -C HEAD"
	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo
	eval ${CMD}
	echo
	echo
}

gitedit() # edit previous commit
{
	case "$1" in
		start | s | S)
			CMD="git stash && git rebase --interactive ; git stash pop > /dev/null && gs"
		;;
		stop | end | e | E)
			CMD="git stash && git rebase --continue && git stash pop > /dev/null && gs"
		;;
		*)
			print_debug "Enter [start] or [stop]" && return 1
		;;
	esac

	print_debug "Execute CMD [${CMD}]"
	eval ${CMD}
	echo
	echo
}


################################################################ SDK compile command

im() # Intel make
{
	COMPILE=0

	case "$1" in
		-c | clean)
			case $2 in
				all)
					CMD="make dirclean V=99"
				;;
				*)
					print_debug "received unknown arg." && return 1
				;;
			esac
		;;
		j1 | -d | debug)
			COMPILE=1
			CMD="make -j1 || make -j1 V=99 > im.log 2>&1"
		;;
		-m | menuconfig)
			CMD="make menuconfig"
		;;
		*)
			COMPILE=1
			CMD="make -j24 || make V=99 > im.log 2>&1"
		;;
	esac

	print_debug "Execute CMD [${CMD}]"
	sleep 1
	echo
	echo

	if [ ${COMPILE} -eq 1 ]; then
		./apply_config_modification.sh `cat active_config | sed 's/.*config\///g'`
		rm -fr dl/rego_frontend*

		date > auto_compile_start_time.txt
		eval ${CMD}
		date > auto_compile_end_time.txt

		print_debug "compile start time" && cat auto_compile_start_time.txt
		print_debug "compile end time" && cat auto_compile_end_time.txt

		./apply_git_info.sh
	else
		eval ${CMD}
	fi
}



bm() # Broadcom make
{
	# move legacy compile log
	mv bm-*.log ../ 2> /dev/null

	BDK=0
	RDKB=0
	CURRENT_TIME=`date +%Y%m%d-%H%M%S`
	LOG_FILE="bm-${CURRENT_TIME}.log"
	CMD="make"
	COMPILE=1
	FILE_LAST_PROFILE=".last_profile"
	PROFILE=`cat ${FILE_LAST_PROFILE}`

	cat patch.version | grep "release: '04'" && BDK=1

	if [ -z "${PROFILE}" ]; then
		# check first arg
		echo -e "\t #### file ["${FILE_LAST_PROFILE}"] is NOT exist"
		echo -e "\t #### step 1. check arg has build profile"
		[[ -n "$1" ]] && [[ "$1" != -* ]] && PROFILE="$1" && shift # consume build profile arg to use option args at below
	fi

	if [ -z "${PROFILE}" ]; then
		# check current directory name
		echo -e "\t #### step 2. check directory name has build profile"
		PROFILE=`get_profile`
	fi

	if [ -z "${PROFILE}" ]; then
		echo -e "\t #### step 3. enter build profile !!!!"
		read -r PROFILE
	fi

	[[ ${PROFILE} == *RDKB* ]] && RDKB=1
#
#	case "${PROFILE}" in
#		HMX_EAX78P | eax78p | 78p)
#			PROFILE="HMX_EAX78P"
#		;;
#		HMX_HPS11_TH_TRUE | hps11-true | 11r)
#			PROFILE="HMX_HPS11R_TRUE"
#		;;
#		HMX_HPS11 | hps11-claro | 11c)
#			PROFILE="HMX_HPS11"
#		;;
#		HMX_HPS11_TH_RELEASE | hps11-ais-release | 11)
#			PROFILE="HMX_HPS11_AIS"
##			PROFILE="HMX_HPS11_TH_RELEASE"
#		;;
##		HMX_HPS11_TH | hps11-ais | 11)
##			PROFILE="HMX_HPS11_TH"
##		;;
#		HMX_XD44AX60 | xd44 | xd | 44)
#			PROFILE="HMX_XD44AX60"
#		;;
#		HMX_HAS12 | has12 | has | 12)
#			PROFILE="HMX_HAS12"
#		;;
#		HMX_HP810 | hp810 | 810)
#			PROFILE="HMX_HP810"
#		;;
#		HMX_HE220_TH_ROUTER | he220r | her | 220r)
#			PROFILE="HMX_HE220_TH_ROUTER"
#		;;
#		HMX_HE220_PH | he220 | he | 220)
#			PROFILE="HMX_HE220_PH"
#		;;
#		HMX_HPS10_TH | hps10th | 10th)
#			PROFILE="HMX_HPS10_TH"
#		;;
#		HMX_G_AX27_TR098 | ax2798 | 2798)
#			PROFILE="HMX_G_AX27_TR098"
#		;;
#		HMX_G_AX60 | ax60 | 60)
#			PROFILE="HMX_G_AX60"
#		;;
#		HMX_HP620_CTC_99 | hp620-ctc-99 | hc99 | 62099)
#			PROFILE="HMX_HP620_CTC_99"
#		;;
#		HMX_HP620_XGS_99 | hp620-xgs-99 | hx99 | 620x99)
#			PROFILE="HMX_HP620_XGS_99"
#		;;
#		HMX_HP620_CTC | hp620-ctc | hc | 620)
#			PROFILE="HMX_HP620_CTC"
#		;;
#		HMX_HP620_XGS | hp620-xgs | hx | 620x)
#			PROFILE="HMX_HP620_XGS"
#		;;
#		BGW320_CTC | bgw-ctc | bc | 320)
#			PROFILE="BGW320_CTC"
#		;;
#		BGW320_CTC_XGS | bgw-xgs | bx | 320x)
#			PROFILE="BGW320_CTC_XGS"
#		;;
#		HMX_WIFI6 | wifi6 | 6)
#			PROFILE="HMX_WIFI6"
#		;;
#		HMX_G_AX27_RELEASE | ax27r | 27r)
#			PROFILE="HMX_G_AX27_RELEASE"
#		;;
#		HMX_G_AX27 | ax27 | 27)
#			PROFILE="HMX_G_AX27"
#		;;
#		HMX_RG_4908 | 4908)
#			PROFILE="HMX_RG_4908"
#		;;
#		HMX_RG_6858-NO-WLAN | 6858-NO-WLAN | no-wlan)
#			PROFILE="HMX_RG_6858-NO-WLAN"
#		;;
#		HMX_RG_6858 | 6858)
#			PROFILE="HMX_RG_6858"
#		;;
#		HMX_RG_6755 | 6755)
#			PROFILE="HMX_RG_6755"
#		;;
#		HMX_RG_11AX | 11ax)
#			PROFILE="HMX_RG_11AX"
#		;;
#		BGW320 | 320)
#			PROFILE="BGW320"
#		;;
#		HMX*)
#			PROFILE="${PROFILE}"
#		;;
#		PROFILE=*)
#			PROFILE=`echo ${PROFILE/PROFILE=/}`
#		;;
#		*)
##			PROFILE=${PROFILE}
#			print_debug "entered PROFILE [${PROFILE}] is unknown" && return 0
#		;;
#	esac
#	shift

	print_debug "set PROFILE to [${PROFILE}]"
	CMD="${CMD} PROFILE=${PROFILE}"

	for arg_entry in $@
	do
		case "${arg_entry}" in
#			reset)
#				CMD="
#git reset --hard HEAD ; 
#git clean -q -f -d ;
#git status"
#				CMD=""
#			;;
			-b | bdk)
				BDK=1
			;;
			-i | -i1 | image)
				CMD="${CMD} buildimage"
			;;
			-i2 | image_final)
				if [ "${BDK}" == "1" ]; then
					CMD="${CMD} buildimage"
				else
					CMD="${CMD} buildimage_final"
				fi
			;;
			-j | -j1 | job)
				CMD="${CMD} BRCM_MAX_JOBS=1"
			;;
			-f | force)
				CMD="${CMD} FORCE=1"
			;;
			-ca | cleanall)
				COMPILE=0
#				CMD="make PROFILE=${PROFILE} inner_kernel_clean && make PROFILE=${PROFILE} hosttools_clean && make PROFILE=${PROFILE} target_clean && make PROFILE=${PROFILE} userspace_clean && make PROFILE=${PROFILE} cleanall"
				CMD="make PROFILE=${PROFILE} cleanall"
			;;
			-c | clean)
				COMPILE=0
				if [ "${RDKB}" == "1" ]; then
#					CMD="bitbake -c cleansstate recipe"   # clean all recipe..?
#					CMD="bitbake -c cleansstate bcalinux" # clean only broadcom SDK..?
					CMD="source meta-rdk-broadcom-bca-system/setup-environment-broadcom-bca && bitbake -c cleansstate recipe && bitbake -c cleansstate bcalinux"   # clean all ..?
					print_debug "###############"
					print_debug "###############"
					print_debug "############### please manually execute below CMD"
					echo "${CMD}"
					return 0
				else
#					CMD="make PROFILE=${PROFILE} inner_kernel_clean && make PROFILE=${PROFILE} hosttools_clean && make PROFILE=${PROFILE} target_clean && make PROFILE=${PROFILE} userspace_clean && make PROFILE=${PROFILE} cleanall"
					CMD="make PROFILE=${PROFILE} clean"
				fi
			;;
			-m | menuconfig)
				COMPILE=0
				CMD="make PROFILE=${PROFILE} menuconfig"
			;;
			-w | while)
				POST_CMD="while [ 1 ] ; do git pull ; sleep 600 ; done"
			;;
			*)
				COMPILE=0
				CMD="${CMD} ${arg_entry}"
			;;
		esac
	done



	if [ "${COMPILE}" == "1" ]; then
		if [ "${RDKB}" == "1" ]; then
			CMD=`echo ${CMD} | sed 's#PROFILE=#HMX_PROFILE=#g'`
			CMD="${CMD} >> ${LOG_FILE} 2>&1 ; tail -n 4 ${LOG_FILE}"
		elif [ "${BDK}" == "1" ]; then
			# update /proc/version
			CMD="touch kernel/linux-*/init/version.c ; ${CMD} >> ${LOG_FILE} 2>&1 ; tail -n 4 ${LOG_FILE}"
		else
			CMD="${CMD} all >> ${LOG_FILE} 2>&1 ; tail -n 4 ${LOG_FILE}"
		fi
		print_debug "Execute CMD [${CMD}]"
		sleep 1

		rm -fr ${LOG_FILE} 2> /dev/null

		START_TIME=`date`
		echo -e "PRINT_DEBUG [${MY_NAME}] : #### START time [${START_TIME}]"
		echo -e "PRINT_DEBUG [${MY_NAME}] : #### START time [${START_TIME}]" >> ${LOG_FILE}

		eval ${CMD}

		END_TIME=`date`
		echo -e "PRINT_DEBUG [${MY_NAME}] : #### END   time [${END_TIME}]"
		echo -e "PRINT_DEBUG [${MY_NAME}] : #### END   time [${END_TIME}]" >> ${LOG_FILE}

#		if [ "${RDKB}" == "1" ]; then
#			CMD="touch FW_info.txt"
#		else
			CMD="./apply_fw_info.sh"
#		fi
		print_debug "Execute CMD : [${CMD}]"
		sleep 1
		eval ${CMD}
	else
		print_debug "Execute CMD [${CMD}]"
		sleep 1
		echo
		echo
		eval ${CMD}
		echo
		echo
	fi

	if [ -n "${POST_CMD}" ]; then
		print_debug "Execute CMD [${POST_CMD}]"
		sleep 1
		echo
		echo
		eval ${POST_CMD}
		echo
		echo
	fi

	print_debug "log file is ${LOG_FILE}"
}








#######################################################
go() # enter container
{
	docker ps -l
	ssh shjung3@localhost -p 10000
}

cpup() # start docker end enter the container
{
	sudo docker compose up -d
	sudo docker ps -l
	ssh shjung3@localhost -p 10000
}

cpdn() # stop docker
{
	sudo docker compose down
}





#######################################################
decrypt_backup_file_hps11() # ex. decrypt_backup_file_hps11 Setting_HPS11-2G_20230317_155020.bin
{
	HMX_IMAGE_ENCRYPT_KEY="hmxHps11Aisnw0x02" # cat targets/HMX_HPS11_2G_AIS/HMX_HPS11_2G_AIS | grep HMX_IMAGE_ENCRYPT_KEY
	INPUT_FILE=$1
	OUTPUT_FILE=

	while [ -z "${INPUT_FILE}" ]; do
		echo -e "\t #### Enter encrypted file name"
		read -r INPUT_FILE
	done

	OUTPUT_FILE="${INPUT_FILE/.bin}.txt"
	CMD="openssl enc -d -aes-256-cbc -salt -k ${HMX_IMAGE_ENCRYPT_KEY} -in ${INPUT_FILE} -out ${OUTPUT_FILE}"
	print_debug "Execute CMD [${CMD}]"
	eval ${CMD} || return 0

	print_debug "OUTPUT file name [${OUTPUT_FILE}]"
}


ais_config_file_key() # generate decrypt key of AIS standard config file
# ex. 
#    decrypt_ais_config_file_key AIS_awn4356528_HPS11_20230320_152242.conf
#    decrypt_ais_config_file_key AIS_8812341234_HPS11_20230320_152242.conf
#    decrypt_ais_config_file_key 8812341234
{
	INPUT=$1
	PPPOE_USERNAME=
	OUTPUT_DECRYPT_KEY=

	while [ -z "${INPUT}" ]; do
		echo -e "\t #### Enter AIS standard config file name or PPPoE username"
		read -r INPUT
	done

	# parsing PPPoE username from filename
	PPPOE_USERNAME=`echo ${INPUT} | sed "s/AIS_//g" | cut -d '_' -f 1`
	print_debug "1. parsed PPPoE Username from filename is [${PPPOE_USERNAME}]"

	# if PPPoE username length < 8, append "0"
	while true ; do
		LENGTH_PPPOE_USERNAME=`expr length "${PPPOE_USERNAME}"`
		if [ ${LENGTH_PPPOE_USERNAME} -lt 10 ]; then
			print_debug "\t PPPoE Username length is less than 10, append [0]"
			PPPOE_USERNAME="${PPPOE_USERNAME}0"
		else
			break
		fi
	done
	print_debug "\t after append [0], PPPoE Username is [${PPPOE_USERNAME}]"

	# trim first two characters
	PPPOE_USERNAME="${PPPOE_USERNAME:2}"
	print_debug "2. after trim first two characters, PPPoE Username is [${PPPOE_USERNAME}]"

	# split string to 1 characters
	X1="${PPPOE_USERNAME:0:1}"
	X2="${PPPOE_USERNAME:1:1}"
	X3="${PPPOE_USERNAME:2:1}"
	X4="${PPPOE_USERNAME:3:1}"
	X5="${PPPOE_USERNAME:4:1}"
	X6="${PPPOE_USERNAME:5:1}"
	X7="${PPPOE_USERNAME:6:1}"
	X8="${PPPOE_USERNAME:7:1}"
	echo "X1 [$X1]"
	echo "X2 [$X2]"
	echo "X3 [$X3]"
	echo "X4 [$X4]"
	echo "X5 [$X5]"
	echo "X6 [$X6]"
	echo "X7 [$X7]"
	echo "X8 [$X8]"

	# make secret key by AIS specification
	OUTPUT_DECRYPT_KEY="${X1}${X2}${X3}${X4}${X5}${X6}${X7}${X8}${X1}${X8}${X2}${X7}${X3}${X6}${X4}${X5}${X5}${X4}${X6}${X3}${X7}${X2}${X8}${X1}${X8}${X7}${X6}${X5}${X4}${X3}${X2}${X1}"

	echo
	echo
	print_debug "OUTPUT decrypt key (Secret key) is [${OUTPUT_DECRYPT_KEY}]"
	echo
}





loop_while_cmd() # it's useful to console command
{
LOOP_COUNT=0
CMD="
ps -w | grep ntp | grep -v grep
ls -al /tmp/hmx_ntp_allowed 2> /dev/null
sleep 1
"
while true ; do
LOOP_COUNT=`expr ${LOOP_COUNT} + 1`
echo "########### LOOP_COUNT ${LOOP_COUNT} ###########" ; date
echo "${CMD}" | while read -r entry; do
[[ -z "${entry}" ]] && continue
echo "# ${entry}" ; eval "${entry}" ; echo
done done
}


cpcat()
{
	if [ -n "$1" ]; then
	cat "$1" | xclip -selection clipboard
	echo "Copied contents of $1 to clipboard."
	else
	echo "Usage: ccat <filename>"
	fi
}

