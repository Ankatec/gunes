# GunesOS GitHub Pages Dağıtım Tanı Raporu

## Tespit Edilen Sorunlar

### 1. ❌ `dist/` Klasörü Repoda Mevcut
- `dist/` klasörü Git tarafından takip ediliyor ve repoya push ediliyor
- Bu, GitHub Actions deploy ile çakışıyor
- `.gitignore` dosyası `dist/` klasörünün İÇİNDE (`dist/.gitignore`), kök dizinde değil

### 2. ❌ GitHub Pages Ayarları
- GitHub Pages muhtemelen "Deploy from a branch" modunda
- "GitHub Actions" moduna geçirilmesi gerekiyor

### 3. ❌ `gonder.bat` Betiği
- `git add .` komutu `dist/` klasörünü de ekliyor
- `--force` ile push yapılıyor, bu da sorunları gizliyor

---

## 🔧 Çözüm Adımları (SIRASIYLA UYGULAYIN)

### Adım 1: `dist/` Klasörünü Git Takibinden Kaldırın
Terminalde (proje klasöründe) şu komutları çalıştırın:

```bash
git rm -r --cached dist
git add .
git commit -m "dist klasorunu Git takibinden kaldir"
git push origin main
```

### Adım 2: `.gitignore` Dosyasını Kök Dizine Taşıyın
Eğer kök dizinde `.gitignore` yoksa, proje kök dizininde bir `.gitignore` dosyası oluşturun:

```gitignore
# Dependencies
node_modules/

# Build output
dist/

# Environment files
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
npm-debug.log*

# Cache
.cache/
.eslintcache
```

### Adım 3: GitHub Pages Ayarlarını Değiştirin
1. Tarayıcıda https://github.com/Ankatec/gunes/settings/pages adresine gidin
2. **"Build and deployment"** bölümünde **"Source"** kısmını bulun
3. "Deploy from a branch" seçeneğini **"GitHub Actions"** olarak değiştirin
4. **Save** butonuna tıklayın

### Adım 4: Yeni `gonder.bat` Dosyasını Kullanın
`gonder.bat` dosyası güncellenmiştir. Artık `dist/` klasörünü Git'e eklemeyecek ve `--force` kullanmayacak.

### Adım 5: Doğrulama
1. GitHub Actions sekmesini kontrol edin: https://github.com/Ankatec/gunes/actions
2. Workflow'un başarıyla tamamlandığını doğrulayın
3. Siteyi ziyaret edin: https://ankatec.github.io/gunes/

---

## ⚠️ Önemli Notlar

- `dist/` klasörü ASLA repoya push edilmemelidir - GitHub Actions build sırasında otomatik oluşturur
- `--force` push kullanmayın, bu sorunlara yol açabilir
- Her push'tan sonra GitHub Actions workflow'unun başarıyla tamamlanıp tamamlanmadığını kontrol edin
- Eğer `ankatec.github.io` alan adı başka bir yere yönlendirilmişse, bu da soruna neden olabilir

---

## Dosya Yapısı (Olması Gereken)

```
gunes/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── src/
├── public/
├── .gitignore          ← KÖK DİZİNDE olmalı
├── index.html
├── package.json
├── vite.config.ts
├── gonder.bat
└── ... (diğer dosyalar)
```

**NOT**: `dist/` klasörü bu listede OLMAMALIDIR - GitHub Actions tarafından otomatik oluşturulur.