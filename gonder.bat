@echo off
title GitHub Guncelleyici - GunesOS
echo Dosyalar GitHub'a gonderiliyor...
git add .
git commit -m "GunesOS Guncelleme: %date% %time%"
git push origin main
echo.
echo Islem basariyla tamamlandi!
pause