#!/bin/bash

url=$1
ep_id=${url##*/}
echo "$ep_id"

mkdir output; cd $_ ;
curl "$url" |
 grep -Eo "https://cdn-image.alphapolis.co.jp/official_manga/page/[a-zA-Z0-9+-]*/$ep_id/[a-zA-Z0-9+-]*/[a-zA-Z0-9+-]*.jpg" > init.txt

sort -u init.txt > output.txt
rm init.txt

file="output.txt"
suffix="500x711.jpg"
hd="1080x1536.jpg"

while IFS= read -r line;
do
	echo "$line" | sed -e "s#$suffix#$hd#g" >> hd_output.txt
done < "$file"

file="hd_output.txt"
image_num=1
while IFS= read -r line;
do
	wget -cO "$image_num".jpg "$line"
	((image_num=image_num+1))
done < "$file"