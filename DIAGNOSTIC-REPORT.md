# 🔍 GunesOS 404 Hata Teşhis Raporu

## 🚨 Tespit Edilen Kritik Sorunlar

### 1. GitHub Pages Kaynak Yapılandırması Yanlış (ANA NEDEN)
Repo'da **iki farklı deploy workflow** çalışıyor:
- `Deploy GunesOS` → `actions/deploy-pages@v4` kullanıyor (GitHub Actions deploy)
- `pages-build-deployment` → GitHub'ın otomatik Pages workflow'u (Branch deploy)

`pages-build-deployment` workflow'unun varlığı, GitHub Pages ayarlarının **"Deploy from a branch"** olarak yapılandırıldığını gösteriyor. Bu durumda GitHub, custom workflow'unuzun deploy'unu **göz ardı eder** ve repo'daki `dist` klasörünü (yanlış path'lerle) yayınlamaya çalışır.

**Çözüm:** Repo Settings → Pages → Source → **"GitHub Actions"** seçilmeli

---

### 2. `dist/` Klasörü Repo'ya Commit Edilmiş (KRİTİK)
`dist/` klasörü repo'da mevcut ve içindeki `index.html` dosyasında asset path'leri **yanlış**:
```html
<!-- Mevcut (YANLIŞ) -->
<script src="/assets/index-CTGXZLsH.js"></script>

<!-- Olması gereken (DOĞRU) - base: '/gunes/' olduğu için -->
<script src="/gunes/assets/index-CTGXZLsH.js"></script>
```

Bu, `dist` klasörünün `base: '/gunes/'` ayarı uygulanmadan oluşturulduğunu gösteriyor.

**Çözüm:** `dist/` klasörünü repodan kaldırın, `.gitignore` ekleyin

---

### 3. `.gitignore` Dosyası Yok (KRİTİK)
Projede `.gitignore` dosyası bulunmuyor! Bu şu sorunlara yol açar:
- `dist/`, `node_modules/` gibi build artifact'leri repoya commit edilebilir
- GitHub Actions build çıktısı ile repo'daki eski `dist/` çakışabilir

---

### 4. `vite.config.ts`'de Duplicate `build` Key (HATA)
```js
return {
  base: '/gunes/',
  build: {           // ← İlk build tanımı
    outDir: 'dist',
    assetsDir: 'assets',
  },
  plugins: [...],
  build: {           // ← İkinci build tanımı (BİRİNCİYİ EZİYOR!)
    rollupOptions: {...},
    chunkSizeWarningLimit: 1000,
  },
};
```
JavaScript'de aynı objede iki aynı key olunca ikincisi birincisini ezer. Yani `outDir` ve `assetsDir` ayarları **kayboluyor**.

---

### 5. Sitemap Hostname Yanlış
```js
Sitemap({
  hostname: 'https://atoms.template.com',  // ← YANLIŞ
})
```
Olması gereken: `https://ankatec.github.io/gunes/`

---

### 6. `gonder.bat` `--force` Push Kullanıyor
`git push origin main --force` tehlikelidir ve geçmiş commit'leri silebilir.

---

## ✅ Düzeltme Planı

1. `.gitignore` dosyası ekle
2. `vite.config.ts`'deki duplicate `build` key'lerini birleştir
3. Sitemap hostname'ini düzelt
4. `dist/` klasörünü git tracking'den kaldır
5. GitHub Pages kaynağını "GitHub Actions" olarak ayarla
6. Yeniden build ve push yap

## 📋 GitHub Pages Ayarı (MANUEL)
Repo → Settings → Pages → Source → **"GitHub Actions"** seçin
Bu adımı mutlaka yapın, yoksa 404 devam eder!