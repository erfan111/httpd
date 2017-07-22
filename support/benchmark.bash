#!/bin/bash
echo "connections,99,99.9,99.99" > "bench_result_$1_$2_tail.csv"
echo "connections,99,99.9,99.99" > "bench_result_$1_$2_def.csv"
for i in `seq $1 $2`;
do
./ab -n 500000 -c $i -e "temp.csv" "http://10.254.254.1/"
a1=`cat "temp.csv" | grep '99,' | awk -F  "," '{print $2}'`
a2=`cat "temp.csv" | grep 99.90 | awk -F  "," '{print $2}'`
a3=`cat "temp.csv" | grep 99.989 | awk -F  "," '{print $2}'`
echo "$i,$a1,$a2,$a3" >> "bench_result_$1_$2_tail.csv"
rm temp.csv
sleep 10
./ab -n 500000 -c $i -e "temp.csv" "http://10.254.254.3/"
a1=`cat "temp.csv" | grep '99,' | awk -F  "," '{print $2}'`
a2=`cat "temp.csv" | grep 99.90 | awk -F  "," '{print $2}'`
a3=`cat "temp.csv" | grep 99.989 | awk -F  "," '{print $2}'`
echo "$i,$a1,$a2,$a3" >> "bench_result_$1_$2_def.csv"
rm temp.csv
sleep 10
done
