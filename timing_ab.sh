#!/bin/bash
# returns time elapsed for each request
# Connection Times (ms)
#  min  mean[+/-sd] median   max timestamp site
#  blank delimited
# Example:
# 1951 2334 508.1 2180 3226 2017-09-13.14:49:04 newcatalog.library.cornell.edu/
# 1081 1557 505.9 1670 2174 2017-09-13.14:49:04 newcatalog.library.cornell.edu/catalog?utf8=%E2%9C%93&q=book+of+knots&search_field=all_fields
# 277 289 10.6 293 303 2017-09-13.14:49:04 newcatalog.library.cornell.edu/catalog/6885529

targets=(
  "newcatalog.library.cornell.edu/"
  "newcatalog.library.cornell.edu/catalog?utf8=%E2%9C%93&q=book+of+knots&search_field=all_fields"
  "newcatalog.library.cornell.edu/catalog/6885529"
  )
dtime=`date +"%F.%T"`
for site in "${targets[@]}"
do
  result=$(ab -n 5 "https://${site}" | grep 'Total: ' | sed -e "s/Total: //g")
  result="$result $dtime $site"
  echo $result
done
