# DJ Mike Pro (Windows Installer – ohne Developer-Setup auf deinem PC)

Du musst **nichts** installieren (kein Visual Studio, kein CMake), wenn du das über **GitHub Actions** bauen lässt.

## So bekommst du nur noch "Setup.exe downloaden und installieren"
1) Erstelle ein neues GitHub Repository (z.B. `dj-mike-pro`)
2) Lade den Inhalt dieses ZIP ins Repo hoch (oder `git push`)
3) Gehe zu **Actions** → **Build Windows Installer** → **Run workflow**
4) Nach dem Build: **Artifacts** → `DJMikePro_Windows_Installer` herunterladen
5) Darin ist: `DJMikePro_Setup.exe` → Doppelklick → Installieren

## Sprachen im Installer
English, Deutsch, Français, Italiano, Español, Română, Magyar

---

Aktueller Stand in diesem Template: Start-App (Fenster + Audio-Testton).
Als nächstes bauen wir Deck A/B, Library, FX, Controller usw.
