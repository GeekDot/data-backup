#!/bin/bash

# today
dt=`date +"%Y-%m-%d"`

# src and dest file path
src="/Users/zhangyi/Documents/yeeyoon/dcp.service.site"
dest="/Users/zhangyi/Downloads/dcp/backup"

day() {
	find ${dest} -type f -name ${last_week}.tar.gz | xargs rm -rf
	cd $src
	find files -type f -mtime 0 | xargs tar cvzf ${dest}/${yesterday}.tar.gz 
}

week() {
	find ${dest} -type f -name ${last_week}_all.tar.gz | xargs rm -rf
	cd $src
	tar cvzf ${dest}/${dt}_all.tar.gz files
}

# Judge Mac or Linux 
if [[ `uname -a` =~ "Darwin" ]]
then
	yesterday=`date -v -1d +"%Y-%m-%d"`
	last_week=`date -v -1w +"%Y-%m-%d"`
else
	yesterday=`date -d '-1 day' +%Y-%m-%d`
	last_week=`date -d '-1 week' +%Y-%m-%d`
fi

# day or week type
if [ "$1" = "day" ]
then
	day
elif [ "$1" = "week" ]
then
	week
else
	echo "--------- *Please input task type* ----------"
	echo "bash $0 day [OR] bash $0 week"
fi