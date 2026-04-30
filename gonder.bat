@echo off
title GitHub Guncelleyici - GunesOS
echo Dosyalar GitHub'a ZORLA gonderiliyor...
git add .
git commit -m "GunesOS Kesin Guncelleme"
:: --force komutu ile engelleri asıyoruz
git push origin main --force
echo.
echo Islem TAMAM! Simdi GitHub Actions sekmesini kontrol et.
pause