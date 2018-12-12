#!/bin/bash

num=`grep GET access.log -o | wc -l`
ip_num=`cat access.log|awk '{print $1}'| grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}.\d{1,3}'|sort -n|uniq -c|wc -l`
most_ip=`cat access.log| awk '{print $1}'|sort -n|uniq -c|sort -nr|head -10|awk '{print $2}'| awk 'NR==2'`
seen_most_ip=`cat access.log| awk '{print $1}'|sort -n|uniq -c|sort -nr|head -10|awk '{print $1}'| awk 'NR==2'`
get_fac=`grep -c "GET /~" access.log`
get_fac_most=`grep -Po 'GET /~\K[^ /]+' access.log|sort -n|uniq -c|sort -nr|head -1|awk '{print $1}'`
get_fac_most_name=`grep -Po 'GET /~\K[^ /]+' access.log|sort -n|uniq -c|sort -nr|head -1|awk '{print $2}'`
popular_resource=`cat access.log|awk '{print $6,$7}'|sort -n|uniq -c|sort -nr|head -4|grep -v 'OPTIONS *'|tr -d '"GET'`
popular_not_fac=`cat access.log|awk '{print $7}'|sort -n|uniq -c|sort -nr|head -4|grep -v '*'|grep -v '/~'|head -1|awk '{print $2}'`
robot=`cat access.log| grep 'robots.txt'|wc -l`
unique_bots=`cat access.log| grep 'robots.txt'|awk '{print $14}'|grep -oP '\w+[B,b]ot'|sort -n|uniq -c|wc -l`
one_name_bot=`cat access.log| grep 'robots.txt'|awk '{print $14}'|grep -oP '\w+\/[0-9]\.[0-9];'|sort -n|uniq -c| sort -nr|awk '{print $2}'|head -1|sed 's/\/[0-9]\.[0-9];//g'`
one_ver_bot=`cat access.log| grep 'robots.txt'|awk '{print $14}'|grep -oP '\w+\/[0-9]\.[0-9];'|sort -n|uniq -c| sort -nr|awk '{print $2}'|head -1|grep -oP '[0-9]\.[0-9]'`
one_req_bot=`cat access.log| grep 'robots.txt'|awk '{print $14}'|grep -oP '\w+\/[0-9]\.[0-9];'|sort -n|uniq -c| sort -nr|awk '{print $1}'|head -1`
two_name_bot=`cat access.log| grep 'robots.txt'|awk '{print $14}'|grep -oP '\w+\/[0-9]\.[0-9];'|sort -n|uniq -c| sort -nr|awk '{print $2}'|head -3|sed 's/\/[0-9]\.[0-9];//g'|awk 'NR==2'`
two_ver_bot=`cat access.log| grep 'robots.txt'|awk '{print $14}'|grep -oP '\w+\/[0-9]\.[0-9];'|sort -n|uniq -c| sort -nr|awk '{print $2}'|head -3|grep -oP '[0-9]\.[0-9]'|awk 'NR==2'`
two_req_bot=`cat access.log| grep 'robots.txt'|awk '{print $14}'|grep -oP '\w+\/[0-9]\.[0-9];'|sort -n|uniq -c| sort -nr|awk '{print $1}'|head -3|awk 'NR==2'`
three_name_bot=`cat access.log| grep 'robots.txt'|awk '{print $14}'|grep -oP '\w+\/[0-9]\.[0-9];'|sort -n|uniq -c| sort -nr|awk '{print $2}'|head -3|sed 's/\/[0-9]\.[0-9];//g'|awk 'NR==3'`
three_ver_bot=`cat access.log| grep 'robots.txt'|awk '{print $14}'|grep -oP '\w+\/[0-9]\.[0-9];'|sort -n|uniq -c| sort -nr|awk '{print $2}'|head -3|grep -oP '[0-9]\.[0-9]'|awk 'NR==3'`
three_req_bot=`cat access.log| grep 'robots.txt'|awk '{print $14}'|grep -oP '\w+\/[0-9]\.[0-9];'|sort -n|uniq -c| sort -nr|awk '{print $1}'|head -3|awk 'NR==3'`
per_denied=`grep 'Permission denied:' error.log -o | wc -l`
fac_no_den=`grep 'Permission denied:' error.log|grep -Po '/home/CS/\K[^ /]+'|sort -n|uniq -c|wc -l`
no_fac_most_den=`grep 'Permission denied:' error.log|grep -Po ': /home/CS/\K[^ /]+'|sort -n|uniq -c|sort -nr|head -1|awk '{print $1}'`
fac_most_den=`grep 'Permission denied:' error.log|grep -Po '/home/CS/\K[^ /]+'|sort -n|uniq -c|sort -nr|head -1|awk '{print $2}'`
uniq_ip_error=`cat error.log| grep -o -P '(?<=\[client ).*(?=:\w)'|sort -n|uniq -c|wc -l`
no_most_uniq_ip_error=`cat error.log| grep -o -P '(?<=\[client ).*(?=:\d)'|sort -n|uniq -c|sort -nr| head -1|awk '{print $1}'`
most_uniq_ip_error=`cat error.log| grep -o -P '(?<=\[client ).*(?=:\d)'|sort -n|uniq -c|sort -nr| head -1|awk '{print $2}'`
uniq_pid=`cat error.log| grep -o -P '(?<=\[pid )(.*)(?=\] )'|awk '{print $1}'| sed 's/\]/\t/'|sort -n|uniq -c|wc -l`
no_most_uniq_pid=`cat error.log| grep -o -P '(?<=\[pid )(.*)(?=\] )'|awk '{print $1}'| sed 's/\]/\t/'|sort -n|uniq -c|sort -nr|head -1|awk '{print $1}'`
most_uniq_pid=`cat error.log| grep -o -P '(?<=\[pid )(.*)(?=\] )'|awk '{print $1}'| sed 's/\]/\t/'|sort -n|uniq -c|sort -nr|head -1|awk '{print $2}'`
total_access=`cat access.log|wc -l`
total_errors=`cat error.log|wc -l`
perc=`echo "scale=4; ($total_errors)*100/($total_access)" | bc`
access_days=`cat access.log|awk '{print $4}'|grep -Po '\d{1,2}\/\w{1,4}\/\w{4}'|sort -n|uniq -c|awk '{print $2":",$1" accesses"}'`
access_total_days=`cat access.log|awk '{print $4}'|grep -Po '\d{1,2}\/\w{1,4}\/\w{4}'|sort -n|uniq -c|wc -l`
error_total_days=`cat error.log|awk '{print $3"/",$2"/",$5}'|tr -d ']'|tr -d ' '|sort -n|uniq -c|wc -l`
error_days=`cat error.log|awk '{print $3"/",$2"/",$5}'|tr -d ']'|tr -d ' '|sort -n|uniq -c|awk '{print $2":",$1" accesses"}'`

echo "Total GET requests: $num"
echo "Total unique IP addresses: $ip_num"
echo "Most common IP address: $most_ip (seen $seen_most_ip times)"
echo "$get_fac of the $num total requests were for faculty/staff pages"
echo "$get_fac_most_name was the most popular fac/staff with $get_fac_most requests to his content"
echo "The 3 most popular resources were:"
echo "REQUESTS     RESOURCE"
echo "$popular_resource"
echo "The most popular non-facstaff resource was [$popular_not_fac]"
echo "There were $robot requests for /robots.txt"
echo "There were $unique_bots bots that indexed the site"
echo "The 3 most active bots were:"
echo "BOTS       VER    REQUESTS"
echo "$one_name_bot   $one_ver_bot   $one_req_bot"
echo "$two_name_bot      $two_ver_bot   $two_req_bot"
echo "$three_name_bot   $three_ver_bot   $three_req_bot"
echo "There were $per_denied permission denied errors"
echo "There were $fac_no_den fac/stafff who had permission denied errors on their content"
echo "The facstaff with the most permission denied errors was $fac_most_den with $no_fac_most_den errors"
echo "There were $uniq_ip_error IP addresses with errors"
echo "The IP address with the most errors was $most_uniq_ip_error with $no_most_uniq_ip_error errors"
echo "There were $uniq_pid unique process IDs in the error log"
echo "PID=$most_uniq_pid showed up with most number of errors, $no_most_uniq_pid"
echo "There was a $perc% frequency of errors"
echo "The access.log file covered $access_total_days days"
echo "$access_days"
echo "The error.log file covered $error_total_days days"
echo "$error_days"
