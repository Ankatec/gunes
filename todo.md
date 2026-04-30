# GüneşOS - Retro OS Simulation

## Design
- **Color Palette**: Desktop teal wallpaper, Taskbar #c0c0c0 silver, Window title #000080 navy, Accent #0078d4
- **Typography**: "Segoe UI", system-ui, sans-serif
- **Wallpaper Fix**: Use `object-position: top` + hide bottom portion (real taskbar covers fake start). Scale image via `background-size: cover`, align to `top center` so the bottom green/start portion of the wallpaper stays below the real taskbar and is cropped.

## Images
- /assets/desktop-wallpaper-teal.png
- /assets/gunesOS-logo-sun.png
- /assets/icon-browser-globe.png
- /assets/icon-mycomputer.png

## Development Tasks
- [x] Copy assets to public/assets
- [x] Create useLocalStorage hook
- [x] Create BootScreen component
- [x] Create Desktop component (wallpaper fix: crop bottom start area)
- [x] Create Taskbar component
- [x] Create WindowFrame component
- [x] Create Notepad app
- [x] Create Terminal app
- [x] Create Minesweeper app
- [x] Create Browser app
- [x] Create KidsGames app
- [x] Create main GunesOS component (window manager)
- [x] Update Index.tsx to render GunesOS
- [x] Run lint & build
- [x] Verify UI via CheckUI