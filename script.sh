#!/bin/bash

out_file="/tmp/index/index.txt"

> $out_file

dir_file="/tmp/test/*"
find_files=$(find $dir_file -maxdepth 0 -type f 2>/dev/null)

if  [ -z "$find_files" ]; then
        echo "Файлы отсутствуют" >> $out_file
else

        for file_name in $find_files
        do

        btime=$(ls -la --time=birth $file_name | awk '{print $6,$7,$8}')
        atime=$(ls -la --time=atime $file_name | awk '{print $6,$7,$8}')

        d_btime=$(date --date="$btime" "+%s")
        d_atime=$(date --date="$atime" "+%s")

        l_line=$(tail -n -1 $file_name)

        echo " $file_name:$d_btime:$d_atime:$l_line" >> $out_file
        done
fi
