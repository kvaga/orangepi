#!/bin/bash
#Color       #define       Value       RGB
#black     COLOR_BLACK       0     0, 0, 0
#red       COLOR_RED         1     max,0,0
#green     COLOR_GREEN       2     0,max,0
#yellow    COLOR_YELLOW      3     max,max,0
#blue      COLOR_BLUE        4     0,0,max
#magenta   COLOR_MAGENTA     5     max,0,max
#cyan      COLOR_CYAN        6     0,max,max
#white     COLOR_WHITE       7     max,max,max

blue=$(tput setaf 4)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

#printf "%40s\n" "${red}This text is blue${normal}"
function log(){
	date=$(date '+%Y-%m-%d %H:%M:%S')
	printf "${date}%40s\n" "${green}[INFO] $1${normal}"
}
function log_error(){
	date=$(date '+%Y-%m-%d %H:%M:%S')
	printf "${date}%40s\n" "${red}[ERROR] $1${normal}"
}
function log_warn(){
	date=$(date '+%Y-%m-%d %H:%M:%S')
	printf "${date}%40s\n" "${yellow}[WARN] $1${normal}"
}
#log test log
#log_error test error log

