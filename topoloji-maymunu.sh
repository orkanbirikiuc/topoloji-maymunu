#!/bin/bash

# topoloji-maymunu

# (uuuuUUUU-UUUU aaaaaaAAA-AAAAAA)

# bu betik araciligiyla tum l2 topoloji avucunun icinde olan, saga
# sola istedigi gibi atlayabilen bir maymunu serbest birakabilirsiniz

# betige vereceginiz arguman maymunu serbest birakacaginiz cihazi
# belirleyecektir, sonrasinda maymun cdp komsularindan network ici
# belirli sarti karsilayan tum cihazlara gecis yapabilecektir.

# guncel atlama sartlari asagidaki gibidir:
# - cihaz bir switch olmali
# - cihazin ip adresi 10.1.0.0/16 uzayinda olmali

# dongu modulleri:
# maymuna ek ozellikler katacak betikler moduller altina eklenebilir
# buraya eklenen betiklere $host argumani verilerek atladigi
# cihazlara yapacagi islemler belirlenebilecektir.

# evrensel moduller:
# evrensel moduller dongu disi modulleri ifade etmektedir
# bunlar maymunun atladigi sirada degil, islerini tamamlayip
# bir dalda otururken yapabilecegi ozellikleri ekler.

# temel modul:
# betigin calismasini, maymunun etrafi hakkinda bilgi edinmesini
# saglayan temel modul ./komsu-cihaz-bulucu.sh moduludur.
# bu modul cihaza tacacs bilgileri ile giris yaptiktan sonra komsu
# cihaz bilgisini edinmek uzere 'sh cdp neigh' komutunu isletir
# ve elde ettigi ciktiyi !!!guncel atlama sartlari!!!'na gore
# duzenler.

# modul degiskenleri:
# modullerin kullanacagi degiskenlerin dongu disinda tanimlanmasini
# saglamaktadir.

# --------------!!!PROGRAM CALISTIRILMADAN ONCE!!!----------------

# ONEMLI NOT: son guncellemeden sonra bu isleri ./sifirla.sh programi
# otomatik olarak gerceklestirmektedir

# !!! girilecek-ip.txt dosyasi icerisinde sadece harita merkez cihazi
# ip adresi olacak sekilde guncellenir. !!!

# !!! girilmeyecek-ip.txt dosyasi icinde sadece nexus ipleri olacak sekilde guncellenir. !!!

# -----------------------!!!BASLANGIC!!!--------------------------

# betik icin kucuk bir kozmetik duzenleme icin gerekli degiskenlerin
# tanimlanmasi.

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# program calistirilmadan once islemlerinin tamamlanmasi

./sifirla.sh "$1"

# maymuna kullanici bilgilerinin verilmesi

echo -e "${GREEN}TACACS kullanici adini giriniz:${NC}"
read username
echo -e "${GREEN}$username kullanicisi icin parola giriniz:${NC}"
read -s password

# --------------------!!!MODUL DEGISKENLERI!!!-------------------


# --------------------!!!MODUL DEGISKENLERI!!!-------------------

# girilecek-ip.txt dosyasinda bir ip oldugu surece devam
# edecek bir donguye girilir.

while [[ -s girilecek-ip.txt ]]
do
    
    # asagidaki sed komutlari duzenleme sirasinda dosyalara
    # eklenen new line karakterlerini siliyor, betik sirasinda
    # bu komut dosyalara her append yapildiktan sonra calistirilacak.

    sed -i 's/\r//g' girilecek-ip.txt
    sed -i 's/\r//g' girilmeyecek-ip.txt

    sleep 0.02

    # ilk once girilecek-ip.txt dosyasinda bulunan girilmeyecek ipler
    # cikartilir ve girilecek-ip.txt dosyasi guncellenir.

    grep -vxf girilmeyecek-ip.txt girilecek-ip.txt > temp-dosya.txt
    mv temp-dosya.txt girilecek-ip.txt

    # burada girilecek-ip.txt'nin ilk satiri $host degiskenine yazilir

    read -r host < <(head -n 1 girilecek-ip.txt)

    # host degiskeninin bos olmasi durumunda donguyu kiracak kosul

    if [[ -z $host ]]; then
        break
    fi
    
    # maymunun cdp komsularina atlamasi icin gerekli olan modul
    # bunu kaldirirsan maymun gercek bir maymun olamaz

    ./komsu-cihaz-bulucu.sh "$host" "$username" "$password"

    # girilen hostun ipsi tekrar girilmemek uzere girilmeyecek-ip.txt
    # dosyasinin sonuna eklenir.
    
    echo $host >> girilmeyecek-ip.txt

    sed -i 's/\r//g' girilmeyecek-ip.txt
    sed -i 's/\r//g' girilmeyecek-ip.txt

    # ---------------!!!MODULLERIN BASLANGICI!!!------------------


    # ------------------!!!MODULLERIN SONU!!!---------------------

    sed -i 's/\r//g' girilmeyecek-ip.txt
    sed -i 's/\r//g' girilmeyecek-ip.txt

done

# -------------------!!!DONGU DISI MODULLER!!!--------------------


# -------------------!!!DONGU DISI MODULLER!!!--------------------
