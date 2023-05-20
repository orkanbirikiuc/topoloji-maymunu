#!/bin/bash

# topoloji maymunu program calistirilmadan once islerini gerceklestiren
# kucuk bir temel modul

# bu betik girilecek-ip.txt dosyasina belirlenen ip adresini yazip
# girilmeyecek-ip.txt dosyasini sifirlamaktir.

echo $1 > girilecek-ip.txt

rm girilmeyecek-ip.txt
touch girilmeyecek-ip.txt

# daha spesifik atlama sartlari eklenmek isteniyorsa buraya 
# eklenmelidir
