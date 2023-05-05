@echo off

set PACKAGE_DEST="%GITHUB_WORKSPACE%\package\virtualxt"
if exist %PACKAGE_DEST%\ rmdir /q /s %PACKAGE_DEST%
mkdir %PACKAGE_DEST%\bios %PACKAGE_DEST%\boot %PACKAGE_DEST%\modules

copy "%GITHUB_WORKSPACE%\SDL2-%SDL2_VERSION%\x86_64-w64-mingw32\bin\SDL2.dll" %PACKAGE_DEST%

copy build\bin\virtualxt.exe %PACKAGE_DEST%
copy modules\*-module.* %PACKAGE_DEST%\modules
copy bios\pcxtbios.bin %PACKAGE_DEST%\bios
copy bios\pcxtbios_640.bin %PACKAGE_DEST%\bios
copy bios\glabios.bin %PACKAGE_DEST%\bios
copy bios\vxtx.bin %PACKAGE_DEST%\bios
copy boot\freedos_hd.img %PACKAGE_DEST%\boot
copy tools\package\itch\itch.windows.toml %PACKAGE_DEST%\.itch.toml
copy tools\npcap\npcap-1.72.exe %PACKAGE_DEST%\npcap-installer.exe
