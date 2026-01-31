\
; DJ Mike Pro - Inno Setup Script (Multi-language)
; Requires: Inno Setup 6
; Build via ISCC.exe DJMikePro.iss /DMyAppVersion="0.1.0"

#define MyAppName "DJ Mike Pro"
#ifndef MyAppVersion
  #define MyAppVersion "0.1.0"
#endif

#define MyAppPublisher "DJ Mike"
#define MyAppExeName "DJMikePro.exe"

; Where staged files are copied by build_and_package.ps1
#define MyStageDir "..\..\dist\DJMikePro"

; Output
#define MyOutputDir "..\out"

[Setup]
AppId={{B3D59D7A-CE36-4F12-9A85-1F6A7F6B0B11}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir={#MyOutputDir}
OutputBaseFilename=DJMikePro_Setup
SetupIconFile=..\assets\djmikepro.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ShowLanguageDialog=yes
LanguageDetectionMethod=locale
LicenseFile=..\assets\LICENSE.txt
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

; Recommended later: signed installer to reduce SmartScreen warnings
; SignTool=signtool

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "romanian"; MessagesFile: "compiler:Languages\Romanian.isl"
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{#MyStageDir}\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
; If you stage additional files (assets, dlls), include them like this:
; Source: "{#MyStageDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

; OPTIONAL: Bundle Microsoft VC++ Runtime (recommended)
; 1) Download vc_redist.x64.exe (Microsoft) and place it in installer/assets/
; 2) Uncomment the next line:
; Source: "..\assets\vc_redist.x64.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#MyAppName}}"; Flags: nowait postinstall skipifsilent

; OPTIONAL: Install VC++ runtime silently if bundled
; Filename: "{tmp}\vc_redist.x64.exe"; Parameters: "/install /quiet /norestart"; StatusMsg: "Installing Microsoft Visual C++ Runtime..."; Flags: runhidden waituntilterminated
