#!/bin/bash
# returns time elapsed for each request
# Connection Times (ms)
#  min  mean[+/-sd] median   max timestamp site
#  blank delimited
# Example - .csv format:
# min,mean,standard_deviation,median,max,timestamp,site
# 1276,1811,498.8,2079,2263,2017-09-13.17:47:04,newcatalog.library.cornell.edu/

targets=(
  "newcatalog.library.cornell.edu/"
  "newcatalog.library.cornell.edu/catalog?utf8=%E2%9C%93&q=book+of+knots&search_field=all_fields"
  "newcatalog.library.cornell.edu/catalog/6885529"
  )
dtime=`date +"%F %T"`
BASEDIR=$(dirname "$0")
BASENAME=`basename "$0"`
TARGETDIR="$BASEDIR/logs"
TARGETFILE="$TARGETDIR/$BASENAME.csv"
[ -d "$TARGETDIR" ] || mkdir -p "$TARGETDIR"
[ -f "$TARGETFILE" ] || echo "min,mean,standard_deviation,median,max,date,time,site" > "$TARGETFILE"

for site in "${targets[@]}"
do
  result=$(ab -n 3 "https://${site}" | grep 'Total: ' | sed -E "s/Total:[ ]+//g")
  result="$result $dtime $site"
  result=$(echo "$result" | sed -E "s|[ ]+|,|g")
  echo $result >> "$TARGETFILE"
done
