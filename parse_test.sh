#!/bin/bash
result=" aa bb        cc  dd    ee ff gg "
echo "$result"

result=$(echo "$result" | sed -E "s/[ ]+/,/g")
echo "$result"
