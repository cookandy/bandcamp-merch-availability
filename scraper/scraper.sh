#!/bin/bash

d=$(date "+%F %T,%N" | cut -b1-23)

tmp_file="$(mktemp).json"
echo "$d INFO Temp file: $tmp_file"

cd /app/scraper/src/bandcamp_merch_availability || exit

echo "$d INFO Starting scraper..."
scrapy crawl bandcamp_merch -o "$tmp_file" 

#mv "$tmp_file" /data/bandcamp_merch.json
echo "$d INFO Moving temp file to web"
mv "$tmp_file" /app/frontend/build/data/bandcamp_merch.json

# sleep for 4 hours
echo "$d INFO Sleeping for $SCRAPER_WAIT_SECONDS seconds"
sleep $SCRAPER_WAIT_SECONDS
