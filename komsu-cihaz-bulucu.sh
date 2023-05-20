#!/bin/bash

# topoloji-maymunu temel modulu: komsu-cihaz-bulucu

# degiskenler maymunun verecegi guncel cihaz bilgisi ile tanimlanir

username="$2"
password="$3"

# kucuk kozmetik duzenlemeler icin renk kodu degiskenlerinin
# tanimlanmasi

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' 

echo -e "${GREEN}hoppp simdi de $1 cihazina atliyoruuum${NC}"

# sshpass programi ile switchlere baglanip komsu cihaz ciktisi
# alinir ve output degiskenine yazilir.

output=$(sshpass -p $password ssh -o StrictHostKeyChecking=no -oKexAlgorithms=+diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1 -l $username $1 'show cdp neigh detail')

# -----------------------!!!ATLAMA SARTLARI!!!------------------------

# output degiskenindeki cikti guncel atlama sartlarina gore duzenlenir

ipss=$(echo "$output" | awk '{ for(i = 1; i <= NF; i++) if ($i ~ /^10\.1\./) print $i }' | sort -u)

# bu bolge disinda atlama sartlari girilmeyecek-ip listesi, dolayisiyla
# ./sifirla.sh betigi ile de duzenlenebilecektir.

# -----------------------!!!ATLAMA SARTLARI!!!------------------------

sleep 0.02

# elde edilen komsu ip bilgisini girilecek-ip.txt'ye ekle

echo "$ipss" >> girilecek-ip.txt
