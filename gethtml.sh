#!/bin/bash

cd /root/script/3_httprobe

a=$(cat httprobe.txt|wc -l)
mkdir $output/3_html
for((i=1;i<$a;i+=1)); do file=$(head -$i httprobe.txt |tail -1) ; echo "touch $output/3_html/$i.html; curl -i -L --speed-time 5 --speed-limit 1 \"$file\" >> $output/3_html/$i.html" >> exe.sh; done

cat exe.sh | parallel --jobs 0 --delay 0.1 --retries 1 ; rm exe.sh
fi
sed -e "/%0d%0aheader:CRLF/d" httprobe.txt >> httprob1e.txt ; mv httprob1e.txt httprobe.txt
