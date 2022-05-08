@echo off
cls
:start

:: ROM Details
set ROM_NAME=RHR4

:: DO NOT CHANGE THE VARIABLES BELOW

:: Working Directory 
setlocal DisableDelayedExpansion
set WORKING_DIR=%~dp0
set WORKING_DIR=%WORKING_DIR:!=^^!%
setlocal EnableDelayedExpansion

:: Tools
call %WORKING_DIR%@baserom_tools.bat

:: Backup Directory 
set BACKUP_DIR=%~dp0Backup\

:: Variables
set ROMFILE="%WORKING_DIR%%ROM_NAME%.smc"
set PATCHFILE="%BACKUP_DIR%%ROM_NAME%.bps"

:: Restore locations
set ROM_BACKUP="%BACKUP_DIR%ROM\latest_%ROM_NAME%.smc"
set LEVELS_BACKUP="%BACKUP_DIR%Levels\latest\"
set MAP16_BACKUP="%BACKUP_DIR%Map16\AllMap16_latest.map16"
set PAL_BACKUP="%BACKUP_DIR%Palettes\Shared_latest.pal"

:: Lunar Magic location
set LM="%WORKING_DIR%Lunar Magic.exe"

:: Check if Lunar Magic exists and download if not
if not exist !LM! (
    echo Executable for Lunar Magic not found, downloading...
    powershell Invoke-WebRequest !LM_DL! -OutFile !LM_ZIP! >NUL
    powershell Expand-Archive !LM_ZIP! -DestinationPath %WORKING_DIR% >NUL
    :: Delete junk files
    del %WORKING_DIR%!LM_ZIP!
    pushd %WORKING_DIR%
    for %%a in (!LM_JUNK!) do (del %WORKING_DIR%%%a)
    echo Done.
)

:: Options
echo Restore Actions -- Only use this with a fresh ROM
echo.
echo   1. Create fresh ROM out of baserom patch.
echo   2. Transfer Global ExAnimation, Overworld, Titlescreen and Credits from backup
echo   3. Import levels from backup
echo   4. Import all of Map16 from backup
echo   5. Import shared palettes from backup
echo   0. Exit
echo.
set /p Action=Enter the number of your choice: 

:: Create fresh baserom from patch.
if "!Action!"=="1" (
    echo Patching fresh baserom...
    if not exist %PATCHFILE% (
        echo Could not find baserom patch. Please try again.
        exit /b
    ) else (
        :: Check if a patched ROM already exists and make a temporary backup
        if exist !ROMFILE! (
            echo Hack already exists, making temporary backup called "%ROM_NAME%.smc~".
            :: Make backup of ROM just in case of error
            copy !ROMFILE! "!ROMFILE!~"
        )
        :: Check for unmodified SMW rom
        set SMWROM=
        if not exist "%WORKING_DIR%\sysLMRestore\smwOrig.smc" (
            echo Could not find an unmodified SMW file. Enter the path to an original, unmodified SMW smc: 
            set /p SMWROM=
        ) else (
            set SMWROM="%WORKING_DIR%\sysLMRestore\smwOrig.smc"
        )
        :: Apply baserom patch with Flips
        "%WORKING_DIR%\flips.exe" --apply %PATCHFILE% !SMWROM! !ROMFILE!
        pause
    )
)
:: Transferr Global ExAnimation, Overworld, Titlescreen and Credits
if "!Action!"=="2" (
    echo Transferring ExAnimation, Overworld, Titlescreen and Credits...
    if not exist !ROM_BACKUP! (
        echo Could not a back-up of your ROM. Run a back-up first before proceeding.
        exit /b
    ) else (
        :: Run Lunar Magic Actions
        !LM! -TransferLevelGlobalExAnim !ROMFILE! !ROM_BACKUP!
        !LM! -TransferOverworld !ROMFILE! !ROM_BACKUP!
        !LM! -TransferTitleScreen !ROMFILE! !ROM_BACKUP!
        !LM! -TransferCredits !ROMFILE! !ROM_BACKUP!
        pause
    )
)
:: Import backed up levels
if "!Action!"=="3" (
    echo Importing levels...
    if not exist !LEVELS_BACKUP! (
        echo Could not find a back-up of your levels.
        exit /b
    ) else (
        !LM! -ImportMultLevels !ROMFILE! !LEVELS_BACKUP!
        pause
    )
)
:: Import backed up map16
if "!Action!"=="4" (
    echo Importing map16...
    if not exist !MAP16_BACKUP! (
        echo Could not find a back-up of map16.
        exit /b
    ) else (
        !LM! -ImportAllMap16 !ROMFILE! !MAP16_BACKUP!
        pause
    )
)
:: Import backed up palettes
if "!Action!"=="5" (
    echo Importing palettes...
    if not exist !PAL_BACKUP! (
        echo Could not find a back-up of palettes.
        exit /b
    ) else (
        !LM! -ImportSharedPalette !ROMFILE! !PAL_BACKUP!
        pause
    )
)
popd

if "!Action!"=="0" (
    echo Have a nice day ^^_^^
    exit /b
)
if '!Action!'=='' echo Nothing is not valid option, please try again.
