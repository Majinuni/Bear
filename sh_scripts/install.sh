#!/usr/bin/env sh

echo "***********************************************"
echo "***************** Upgrades ********************"
echo "***********************************************"

echo "@edge http://nl.alpinelinux.org/alpine/edge/main" \
>> /etc/apk/repositories
echo "@edgecommunity http://nl.alpinelinux.org/alpine/edge/community" \
>> /etc/apk/repositories
echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" \
>> /etc/apk/repositories

apk -U upgrade --available

echo "***********************************************"
echo "***************** install *********************"
echo "***********************************************"

apk add postgresql-dev python3-dev zlib-dev gcc musl-dev geoip-dev

apk add libressl2.7-libcrypto@edge geos-dev@testing gdal-dev@testing

echo "***********************************************"
echo "---install dependencies (including django)  ---"
echo "***********************************************"

pip install --upgrade pip
pip3 install -r requirements.txt
pip3 freeze
