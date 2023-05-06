@echo off
setlocal EnableDelayedExpansion

echo ------------------------------------------------------------
set "appdata_dir=%USERPROFILE%\AppData"
set "pyside2_uic_path="
for /d %%I in ("%appdata_dir%\Local\Programs\Python\Python*") do (
    if exist "%%~fI\Scripts\pyside2-uic.exe" (
        set "pyside2_uic_path=%%~fI\Scripts\pyside2-uic.exe"
        goto :found_pyside2_uic
    )
)
for /r "%cd%" %%I in (pyside2-uic.exe) do (
    if exist "%%~fI" (
        set "pyside2_uic_path=%%~fI"
        goto :found_pyside2_uic
    )
)
echo pyside2-uic.exe not found in %appdata_dir%\Local\Programs\Python\Python*
echo ------------------------------------------------------------
goto :get_pyside2_uic_path

:get_pyside2_uic_path
for /f "delims=" %%I in ('powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.OpenFileDialog; $f.InitialDirectory = (Get-Item -Path '.\').FullName; $f.Filter = 'Pyside2 uic executable (pyside2-uic.exe)|pyside2-uic.exe'; $f.Title = 'Select pyside2-uic.exe'; $f.ShowDialog() | Out-Null; $f.FileName"') do set "pyside2_uic_path=%%I"
if not defined pyside2_uic_path (
    echo pyside2-uic.exe not found. Exiting.
    echo ------------------------------------------------------------
    goto :end
)

:found_pyside2_uic
echo pyside2-uic.exe found: %pyside2_uic_path%
echo ------------------------------------------------------------
set "ui_files=%*"
echo UI files: %ui_files%
echo ------------------------------------------------------------
if not defined ui_files (
    for /f "delims=" %%I in ('powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.OpenFileDialog; $f.InitialDirectory = (Get-Item -Path '.\').FullName; $f.Filter = 'UI Files (*.ui)|*.ui'; $f.Multiselect = $true; $f.Title = 'Select UI files'; $f.ShowDialog() | Out-Null; $f.FileNames"') do set "ui_files=!ui_files! "%%I""
)
if not defined ui_files (
    echo UI files not found. Exiting.
    echo ------------------------------------------------------------
    goto :end
)

:found_ui_files
echo UI files found: %ui_files%
echo ------------------------------------------------------------
for %%I in (%ui_files%) do (
    set "ui_file=%%~fI"
    set "py_file=!ui_file:.ui=.py!"

    echo Converting !ui_file! to !py_file!
    echo ------------------------------------------------------------
    "%pyside2_uic_path%" "!ui_file!" -o "!py_file!"

    if errorlevel 1 (
        echo Failed to convert !ui_file! to Python file. Skipping.
        echo ------------------------------------------------------------
    ) else (
        echo Successfully converted !ui_file! to Python file: !py_file!
        echo ------------------------------------------------------------
    )
)

:end
pause
exit /b 1
