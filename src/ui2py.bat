@echo off
setlocal enabledelayedexpansion

set uiext=.ui
set pyext=.py

set pyside2-uic=env\Scripts\pyside2-uic.exe
if not exist %pyside2-uic% call :get_pyside2_uic_path

for %%f in (%*) do (
    set filename=%%~nf
    set ext=%%~xf
    if /i !ext! == !uiext! (
        echo Converting !filename!!ext! to !filename!!pyext!
        %pyside2-uic% %%f -o !filename!!pyext!
    )
)

echo Done!
pause
goto :eof

:get_pyside2_uic_path
set "dialogTitle=Select pyside2-uic.exe"
set "fileFilter=Pyside2 uic executable (pyside2-uic.exe)|pyside2-uic.exe"
set "initialDir=%~dp0env\Scripts"
set "pyside2_uic_path="
set "vbs=%temp%\pyside2_uic_path.vbs"

REM Create a shell object and browse for the folder containing pyside2-uic.exe
>"%vbs%" echo Set objShell = CreateObject^("Shell.Application"^)
>>"%vbs%" echo Set objFolder = objShell.BrowseForFolder^(0, dialogTitle, ^&H4000, initialDir^)

REM If the folder is not empty, set pyside2_uic_path to the path of pyside2-uic.exe
>>"%vbs%" echo If Not objFolder Is Nothing Then
>>"%vbs%" echo     Set objFolderItem = objFolder.Self
>>"%vbs%" echo     pyside2_uic_path = objFolderItem.Path ^& "\pyside2-uic.exe"
>>"%vbs%" echo End If

REM Run the VBScript and set pyside2-uic to the path of pyside2-uic.exe
for /f "delims=" %%I in ('cscript //nologo "%vbs%"') do set "pyside2_uic_path=%%I"
del "%vbs%"
if not defined pyside2_uic_path (
    echo pyside2-uic.exe not found. Exiting.
    pause
    exit /b 1
)
set "pyside2-uic=%pyside2_uic_path%"
goto :eof
