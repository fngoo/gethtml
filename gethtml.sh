#!/bin/bash

x=4 ; input=httprobe.txt ; export x=4 ; export input=httprobe.txt
length=`wc -l $input|grep -o -P ".*?(?=\ )"`
#dir_num=$((x*x))
if [ $length -lt $x ]
then
i=1
mkdir $output/3_html
a=$(cat httprobe.txt|wc -l)
echo '#!/bin/bash'>getjs1.sh
echo 'for((i=1;i<'$a';i+=1)); do file=$(head -$i httprobe.txt |tail -1); output=$output; touch $output/3_html/$i.html; curl -L $file>>$output/3_html/$i.html; done'>>getjs1.sh
rm getjs1.sh


else

a=$(cat httprobe.txt|wc -l) ; let ac=a/4 ; let dc=a/2 ; let rock=ac*3

mkdir $output/3_html
echo '#!/bin/bash'>getjs1.sh
echo 'for((i=1;i<'$ac';i+=1)); do file=$(head -$i httprobe.txt |tail -1); output=$output; touch $output/3_html/$i.html; curl -L $file>>$output/3_html/$i.html; done'>>getjs1.sh
echo '#!/bin/bash'>getjs2.sh
echo 'for((i='$ac';i<'$dc';i+=1)); do file=$(head -$i httprobe.txt |tail -1); output=$output; touch $output/3_html/$i.html; curl -L $file>>$output/3_html/$i.html; done'>>getjs2.sh
echo '#!/bin/bash'>getjs3.sh
echo 'for((i='$dc';i<'$rock';i+=1)); do file=$(head -$i httprobe.txt |tail -1); output=$output; touch $output/3_html/$i.html; curl -L $file>>$output/3_html/$i.html; done'>>getjs3.sh
echo '#!/bin/bash'>getjs4.sh
echo 'for((i='$rock';i<='$a';i+=1)); do file=$(head -$i httprobe.txt |tail -1); output=$output; touch $output/3_html/$i.html; curl -L $file>>$output/3_html/$i.html; done'>>getjs4.sh
echo '#!/bin/bash'>exe_getjs.sh
echo 'output=$output'>>exe_getjs.sh
echo 'bash getjs1.sh'>>exe_getjs.sh
echo 'bash getjs2.sh'>>exe_getjs.sh
echo 'bash getjs3.sh'>>exe_getjs.sh
echo 'bash getjs4.sh'>>exe_getjs.sh

cat exe_getjs.sh | parallel --jobs 0 --progress --delay 1 ; rm getjs1.sh ; rm getjs2.sh ; rm getjs3.sh ; rm getjs4.sh ;  rm exe_getjs.sh
fi
