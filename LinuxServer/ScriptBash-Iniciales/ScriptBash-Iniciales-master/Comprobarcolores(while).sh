#!/bin/bash

cont=0
while [ $cont -le 100 ]
do
	segundo=`expr $cont + 1`
	tercero=`expr $segundo + 1`
	echo -e '\e['$cont'm JAJA '$cont' - \e['$segundo'm JAJA '$segundo' - \e['$tercero'm JAJA '$tercero
	cont=`expr $cont + 3`
done
echo -e '\e[0m'
