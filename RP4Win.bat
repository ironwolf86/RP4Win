::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Based on Flerp/RetroCake at https://github.com/Flerp/RetroCake                                        
:: Modified By: ironwolf86
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off

:: Start program maximized in a new window if not set in command line call to program
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b

:AdminCheck
::Checks if the batch file was run as admin. If not it yells at you and will exit.
net session >nul 2>&1
if %errorLevel% == 0 (
	goto setvars
) else (
	goto NoAdmin
)

:setvars
prompt $P$G
title RP4Win (Retropie - Windows Edition)
set version=0.0.1beta
set lastMod="March 18, 2022"
set raVERSION=1.10.0
::Sets date and time variables for the backup files
::Important:  This results a fixed day/time stamp as environment variable while in current batch script session.
::E.g., it captures the exact day/time this script started, and then this environment variable becomes reusable
::until this script is closed or invoke time refresh.  Will improve on this later on.
set CurDate=%date:~4,10%
set CurTime=%time:~0,8%
set FormDate=%CurDate:/=%
set FormTime=%CurTime::=%
:: Display logo
cls
color 04
echo .
echo .     ____  ____  _  ___        ___       
echo .    |  _ \|  _ \| || \ \      / (_)_ __  
echo .    | |_) | |_) | || |\ \ /\ / /| | '_ \ 
echo .    |  _ <|  __/|__   _\ V  V / | | | | |
echo .    |_| \_\_|      |_|  \_/\_/  |_|_| |_|
echo .
echo .
echo .     .-/+ssyso+/.        ./+osyss+/-.
echo .   .hhdos+/-:-+/shds.  .ydhs/+-:-/+osdyh`
echo .   :Mo   ``       `+m-:m/`       ``  `sM-
echo .   .Mh`   `-::.     +NN/     .::-`   `dN`
echo .    +N+      `:o+-  +MM:  -oo:`      oN/
echo .     oNo.       .+hhNMMNhh+.       .sN+
echo .      -hh+.     `+MMMMMMMN/`     -ohh-
echo .       `-hNmsoshmMNhyssydNMmhsoymms-`
echo .       :hds/-.-dN+.`    `-sm/.-:ohd/
echo .      oN+`  `/dMd.        .mmo.  `/my`
echo .     -Mo  -omNmmmdho////oshddmms-  :M+
echo .     oM++hNmo-.``.:yMMMN+.```.:smdo:Mh`
echo .   -ydymMMy.        \MM/        -mMmohd+`
echo .  /Ns. /Mm`         :MM:         -Ms  :mh`
echo . .Ny   -Mh          sMMs         `My   :M+
echo . -M+   +MN-       .sMMMMs.      `sMm   .Ms
echo . `dd` .mMMNy/-.-/shy+/\+shy+:-:odMMM+ `sN-
echo .  .dd+dmhdmMMMNMN/`      `/mMMMMds++yshm:
echo .   `mMh`  ./hMMM/          /MMd:`   `mM:
echo .    :Ms      /NM:          /Ms`      hm
echo .     hm.      :Mm-`      `:my       :No
echo .     `hm:`     mMMho/::/sdMM/     `+ms
echo .       \dds+::sMMNmhyyyyhmNMm/:/+ymy:
echo .         \yNMMMs.        `hMMNd+:`
echo .           `:odm+.      -sNs/.
echo .               -sddhyyhmh+`
echo .                   `...`
echo .
echo .  ========PRESS ANY KEY TO CONTINUE==========
pause>nul
goto CusInstallCheck

:CusInstallCheck
::Checks dummy file in AppData for a custom install directory.
if EXIST %APPDATA%\RP4Win\CusInstallDir.txt goto PullCusDir
if EXIST C:\RP4Win\RP4Win goto CusInstallN
goto CusInstall

:PullCusDir
::Pulls the directory string from a custom install text file.
set /P wasteDir=<%APPDATA%\RP4Win\CusInstallDir.txt
::Swaps the variable from wasteDir to rp4winDir removing the trailing space.
set rp4winDir=%wasteDir:~0,-1%
goto CheckRP4Win

:CusInstall
::Prompts to install in a custom directory or default C:\RP4Win.
cls
color 07
echo =
echo ==========================================
echo =   Install RP4Win to a storage device ...
echo ==========================================
echo =
echo =   This will install some tools to the chosen path
echo =
echo =   1.) DEFAULT PATH (C:\RP4Win)
echo =
echo =   2.) CUSTOM PATH (Select drive for RP4Win install)
echo =
echo =------------------------------------------
echo =
echo ============ Enter Q to quit ==============
echo =
CHOICE /C 12Q /N /M "=->  Enter Menu Selection: "
IF ERRORLEVEL ==3 GOTO Quit
IF ERRORLEVEL ==2 GOTO CusInstallY
IF ERRORLEVEL ==1 GOTO CusInstallN

:CusInstallY
::Prompts to enter the custom installation path.
cls
color 07
echo =
echo ===========================================
echo =         CUSTOM INSTALL DIRECTORY        =
echo ===========================================
echo =
echo =    Enter the letter only of the drive you 
echo =    wish to use.
echo = 
echo =    Example: D:\
echo = 
echo =    You would type D and press enter...
echo = 
set /P rpDrive="=->  Letter of drive, and then press enter/return key: "
set rp4winDir=%rpDrive%:\RP4Win
::writes the directory to %APPDATA%\RP4Win\ for use when launching the bat file.
mkdir %APPDATA%\RP4Win\
echo %rp4winDir% > %APPDATA%\RP4Win\CusInstallDir.txt
goto CheckRP4Win

:CusInstallN
::Sets the install path to default C:\RP4Win
set rp4winDir=C:\RP4Win
goto CheckRP4Win

:CheckRP4Win
::Checks if RP4Win is already installed
IF EXIST %rp4winDir%\Temp\ goto permcheck
goto SetRPDir

:SetRPDir
::Creates the directories needed for installation, then sets the permissions to Everyone R/W for use with the shares.
mkdir %rp4winDir%
mkdir %rp4winDir%\Temp
mkdir %rp4winDir%\Temp\Backup
mkdir %rp4winDir%\Tools
mkdir %rp4winDir%\RetroArch
mkdir %rp4winDir%\EmulationStation
mkdir %rp4winDir%\EmulationStation\.emulationstation
mkdir %rp4winDir%\EmulationStation\.emulationstation\roms
icacls "%rp4winDir%" /grant everyone:(OI)(CI)F /T
echo pls no delete > %rp4winDir%\RP4Win
goto Tools

:permcheck
::Changes permissions to Everyone R/W for use with the shares, secondary check for already installed just in case.
IF EXIST %rp4winDir%\RP4Win goto Tools
goto permss

:permss
::Changes permissions to Everyone R/W for use with the shares, secondary check for already installed just in case.
echo =
echo =   Checking file/folder permissions and changing them to 'All' as needed.
echo =   This ensures that the user can access and modify all files and folders within
echo =   RP4Win directory.
echo = 
echo =   please wait...
echo =
icacls "%rp4winDir%" /grant everyone:(OI)(CI)F /T
echo pls no delete > %rp4winDir%\RP4Win
goto Tools
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Tools
cls
color 07
set tempDir=%rp4winDir%\Temp
set toolsDir=%rp4winDir%\Tools
set RADir=%rp4winDir%\RetroArch	
set esDir=%rp4winDir%\EmulationStation
set systemsDir=%esDir%\Emulators
set romsDir=%esDir%\.emulationstation\roms
set themesDir=%esDir%\.emulationstation\themes
goto check7z


:check7z
::Checks for 7z installation. (needed to use the bat file.)
IF EXIST "%toolsDir%\7za\7za.exe" goto WGETCheck
::Checks if installation is x86 or x86_64
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto install7z64
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto install7z32
	)

:install7z32
::Installs 7z with pretty information.
cls
color 07
echo ===========================================
echo =           SETTING UP 7ZA...             =
echo ===========================================
mkdir %toolsDir%\7za
::Pulls 7za and unzips via powershell. (All future unzipping is done with 7za, as it is faster and cleaner.
powershell -command (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/ironmine86/RP4Win/master/7zip/7z2107_x86.zip','%toolsDir%\7za\7za.zip');(new-object -com shell.application).namespace('%toolsDir%\7za').CopyHere((new-object -com shell.application).namespace('%toolsDir%\7za\7za.zip').Items(),16)
cls
echo ===========================================
echo =     Cleaning up downloaded file(s)      =
echo ===========================================
::Waits for the zip to be fully closed
ping 127.0.0.1 -n 2 >nul
::Deletes downloaded zip
del %toolsDir%\7za\7za.zip
IF EXIST "%toolsDir%\7za\7za.exe" goto WGETCheck
goto 7zerror

:install7z64
::Installs 7z with pretty information.
cls
color 07
echo ===========================================
echo =           SETTING UP 7ZA...             =
echo ===========================================
mkdir %toolsDir%\7za
::Pulls 7za and unzips via powershell. (All future unzipping is done with 7za, as it is faster and cleaner.
powershell -command (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/ironmine86/RP4Win/master/7zip/7z2107_x64.zip','%toolsDir%\7za\7za.zip');(new-object -com shell.application).namespace('%toolsDir%\7za').CopyHere((new-object -com shell.application).namespace('%toolsDir%\7za\7za.zip').Items(),16)
cls
echo ===========================================
echo =     Cleaning up downloaded file(s)      =
echo ===========================================
::Waits for the zip to be fully closed
ping 127.0.0.1 -n 2 >nul
::Deletes downloaded zip
del %toolsDir%\7za\7za.zip
IF EXIST "%toolsDir%\7za\7za.exe" goto WGETCheck
goto 7zerror

::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:WGETCheck
IF EXIST "%toolsDir%\Wget\wget.exe" goto SGitCheck
::Checks if installation is x86 or x86_64
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto wget64
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto wget32
	)

:wget32
::Installs wget binaries with pretty information.
cls
echo ===========================================
echo =           SETTING UP WGET               =
echo ===========================================
mkdir %toolsDir%\Wget
::Pulls wget binaries via powershell. (All future unzipping is done with 7za, as it is faster and cleaner.) 
powershell -command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/ironmine86/RP4Win/master/wget/wget-1.20.3-win32.zip','%toolsDir%\Wget\Wget.zip')
ping 127.0.0.1 -n 3 > nul
%toolsDir%\7za\7za.exe x "%toolsDir%\Wget\Wget.zip" -o"%toolsDir%\Wget" -aoa > nul
cls
echo ===========================================
echo =     Cleaning up downloaded file(s)      =
echo ===========================================
::Waits for the zip to be fully closed
ping 127.0.0.1 -n 2 >nul
::Deletes downloaded zip
del %toolsDir%\Wget\Wget.zip
IF EXIST "%toolsDir%\Wget\wget.exe" goto SGitCheck
goto WGETerror

:wget64
::Installs wget binaries with pretty information.
cls
echo ===========================================
echo =           SETTING UP WGET               =
echo ===========================================
mkdir %toolsDir%\Wget
::Pulls wget binaries via powershell. (All future unzipping is done with 7za, as it is faster and cleaner.) 
powershell -command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/ironmine86/RP4Win/master/wget/wget-1.20.3-win64.zip','%toolsDir%\Wget\Wget.zip')
ping 127.0.0.1 -n 3 > nul
%toolsDir%\7za\7za.exe x "%toolsDir%\Wget\Wget.zip" -o"%toolsDir%\Wget" -aoa > nul
cls
echo ===========================================
echo =     Cleaning up downloaded file(s)      =
echo ===========================================
::Waits for the zip to be fully closed
ping 127.0.0.1 -n 2 >nul
::Deletes downloaded zip
del %toolsDir%\Wget\Wget.zip
IF EXIST "%toolsDir%\Wget\wget.exe" goto SGitCheck
goto WGETerror
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:SGitCheck
::Checks if git is installed (Used for various functions in the bat file)
IF EXIST "%toolsDir%\git\bin\git.exe" goto VCREDISTCheck
::Checks if installation is x86 or x86_64
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto sgit64
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto sgit32
	)

:sgit32
::Installs git the same way as 7za
cls
echo ===========================================
echo =        SETTING UP GIT 32BIT             =
echo ===========================================
%toolsDir%\Wget\wget.exe -q https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/PortableGit-2.35.1.2-32-bit.7z.exe -O "%tempDir%\git.zip"
mkdir %toolsDir%\git
%toolsDir%\7za\7za.exe x "%tempDir%\git.zip" -o"%toolsDir%\git" -aoa > nul
cls
echo ===========================================
echo =     Cleaning up downloaded file(s)      =
echo ===========================================
ping 127.0.0.1 -n 3 > nul
del %tempDir%\git.zip
IF EXIST "%toolsDir%\git\bin\git.exe" goto VCREDISTCheck
goto GITerror

:sgit64
::Installs git the same way as 7za
cls
echo ===========================================
echo =        SETTING UP GIT 64BIT             =
echo ===========================================
%toolsDir%\Wget\wget.exe -q https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/PortableGit-2.35.1.2-64-bit.7z.exe -O "%tempDir%\git.zip"
mkdir %toolsDir%\git
%toolsDir%\7za\7za.exe x "%tempDir%\git.zip" -o"%toolsDir%\git" -aoa > nul
cls
echo ===========================================
echo =     Cleaning up downloaded file(s)      =
echo ===========================================
ping 127.0.0.1 -n 3 > nul
del %tempDir%\git.zip
IF EXIST "%toolsDir%\git\bin\git.exe" goto VCREDISTCheck
goto GITerror
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:VCREDISTCheck
::Checks if RP4Win has installed the Visual Studio redistributables
IF EXIST "%toolsDir%\VC" goto DirectXSetupCheck
cls
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto VCRedistInstall64
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto VCRedistInstall32
	)

:VCRedistInstall64
cls
echo ===========================================
echo =      SETTING UP VC REDIST 64BIT         =
echo ===========================================
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/C/6/D/C6D0FD4E-9E53-4897-9B91-836EBA2AACD3/vcredist_x86.exe -O "%tempDir%\VC_Redist_2010_32.exe"
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/A/8/0/A80747C3-41BD-45DF-B505-E9710D2744E0/vcredist_x64.exe -O "%tempDir%\VC_Redist_2010_64.exe"
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe -O "%tempDir%\VC_Redist_2012_32.exe"
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe -O "%tempDir%\VC_Redist_2012_64.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/highdpimfc2013x86enu -O "%tempDir%\VC_Redist_2013_32.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/highdpimfc2013x64enu -O "%tempDir%\VC_Redist_2013_64.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/vs/17/release/vc_redist.x86.exe -O "%tempDir%\latest_32.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/vs/17/release/vc_redist.x64.exe -O "%tempDir%\latest_64.exe"
%tempDir%\VC_Redist_2010_32.exe /install /quiet
%tempDir%\VC_Redist_2010_64.exe /install /quiet
%tempDir%\VC_Redist_2012_32.exe /install /quiet
%tempDir%\VC_Redist_2012_64.exe /install /quiet
%tempDir%\VC_Redist_2013_32.exe /install /quiet
%tempDir%\VC_Redist_2013_64.exe /install /quiet
%tempDir%\latest_32.exe /install /quiet
%tempDir%\latest_64.exe /install /quiet
echo VCRedistInstalled > "%toolsDir%\VC"
cls
echo ===========================================
echo =     Cleaning up downloaded file(s)      =
echo ===========================================
ping 127.0.0.1 -n 3 > nul
del "%tempDir%\VC_Redist_2010_32.exe"
del "%tempDir%\VC_Redist_2010_64.exe"
del "%tempDir%\VC_Redist_2012_32.exe"
del "%tempDir%\VC_Redist_2012_64.exe"
del "%tempDir%\VC_Redist_2013_32.exe"
del "%tempDir%\VC_Redist_2013_64.exe"
del "%tempDir%\latest_32.exe"
del "%tempDir%\latest_64.exe"
goto DirectXSetupCheck

:VCRedistInstall32
cls
echo ===========================================
echo =      SETTING UP VC REDIST 32BIT         =
echo ===========================================
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/C/6/D/C6D0FD4E-9E53-4897-9B91-836EBA2AACD3/vcredist_x86.exe -O "%tempDir%\VC_Redist_2010_32.exe"
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe -O "%tempDir%\VC_Redist_2012_32.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/highdpimfc2013x86enu -O "%tempDir%\VC_Redist_2013_32.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/vs/17/release/vc_redist.x86.exe -O "%tempDir%\latest_32.exe"
%tempDir%\VC_Redist_2010_32.exe /install /quiet
%tempDir%\VC_Redist_2012_32.exe /install /quiet
%tempDir%\VC_Redist_2013_32.exe /install /quiet
%tempDir%\latest_32.exe /install /quiet
echo VCRedistInstalled > "%toolsDir%\VC"
cls
echo ===========================================
echo =     Cleaning up downloaded file(s)      =
echo ===========================================
ping 127.0.0.1 -n 3 > nul
del "%tempDir%\VC_Redist_2010_32.exe"
del "%tempDir%\VC_Redist_2012_32.exe"
del "%tempDir%\VC_Redist_2013_32.exe"
del "%tempDir%\latest_32.exe"
goto DirectXSetupCheck
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:DirectXSetupCheck
IF EXIST "%toolsDir%\DX" goto Main
cls
echo ===========================================
echo =          SETTING UP DIRECTX             =
echo ===========================================
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe  -O "%tempDir%\dxwebsetup.exe"
%tempDir%\dxwebsetup.exe /Q
echo DXInstalled > "%toolsDir%\DX"
cls
echo ===========================================
echo =     Cleaning up downloaded file(s)      =
echo ===========================================
ping 127.0.0.1 -n 3 > nul
del "%tempDir%\dxwebsetup.exe"
goto Main
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Main
cls
color 07
echo Hello %USERNAME%, welcome to RP4Win v.%version%
echo ===========================================
echo =               Main Menu                 =
echo ===========================================
echo =
echo =    Important:  This script can overwrite 
echo =    your configurations and game data !!        
echo =
echo =    1.) AUTOMATED INSTALLERS
echo =
echo -------------------------------------------
echo =
echo =    2.) MANAGE EMULATIONSTATION
echo =    3.) MANAGE RETROARCH
echo =    4.) MANAGE ADDITIONAL EMULATORS
echo =    5.) MANAGE ROM DIRECTORIES
echo =    6.) MANAGE DEDICATED EMUBOX SETTINGS
echo =
echo -------------------------------------------
echo =
echo =    7.) SYSTEM CLEANUP
echo =    8.) ROM SCRAPER (non-functional)
echo =
echo -------------------------------------------
echo =
echo =    9.) UPDATE RP4WIN SCRIPT
echo =
echo -------------------------------------------
echo =
echo =    Q.) Press Q to quit
echo =
echo =    Last Modified: %lastMod%
echo =
CHOICE /C 123456789Q /N /M "=-> Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO Quit
IF ERRORLEVEL ==9 GOTO Selection9
IF ERRORLEVEL ==8 GOTO Selection8
IF ERRORLEVEL ==7 GOTO Selection7
IF ERRORLEVEL ==6 GOTO Selection6
IF ERRORLEVEL ==5 GOTO Selection5
IF ERRORLEVEL ==4 GOTO Selection4
IF ERRORLEVEL ==3 GOTO Selection3
IF ERRORLEVEL ==2 GOTO Selection2
IF ERRORLEVEL ==1 GOTO Selection1
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection1
::Menu for automated full installers (Emulationstation + RetroArch + Config Generation + ROM Directory Setup)
cls
echo ===========================================
echo =         Automated Installers            =
echo ===========================================
echo **1.) FULL SETUP WITH DEFAULT ROM DIRECTORY (%romsDir%\SYSTEMNAME)
echo -------------------------------------------
echo **2.) FULL SETUP WITH CUSTOM ROM DIRECTORY
echo -------------------------------------------
echo **3.) FULL SETUP WITHOUT ROM DIRECTORY (NEED TO EDIT ES_SYSTEMS.CFG)
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
echo **4.) RETURN TO MAIN MENU
echo ===========================================
CHOICE /C 1234 /N /T 60 /D 4 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==4 GOTO Main
IF ERRORLEVEL ==3 GOTO Selection1_BrandNewBlank
IF ERRORLEVEL ==2 GOTO Selection1_BrandNewCus
IF ERRORLEVEL ==1 GOTO Selection1_BrandNewDef
::==============================================
::==============================================
:Selection1_BrandNewDef
::Creates temporary file to guide the installation process for default installation (ROM directory inside RP4Win directory)
cls
echo Temp file used for installation. IF you see this file something bad happened > %tempDir%\BrandNewDef
goto updateES
::==============================================
:Selection1_BrandNewCus
::Creates temporary file to guide the installation process for custom ROM directory installation (ROM directory set via variable)
cls
echo Temp file used for installation. IF you see this file something bad happened > %tempDir%\BrandNewCus
goto updateES
::==============================================
:Selection1_BrandNewBlank
::Creates temporary file to guide the installation process for Blank installation (No es_systems.cfg setup)
cls
echo Temp file used for installation. IF you see this file something bad happened > %tempDir%\BrandNewBlank
goto updateES
::==============================================
















::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection2
::Menu for Managing Emulationstation updates, config, and themes.
cls
echo ===========================================
echo         Manage Emulationstation
echo ===========================================
echo **1.) CHECK EMULATIONSTATION FOR UPDATES
echo -------------------------------------------
echo **2.) MANAGE es_systems.cfg FILE
echo -------------------------------------------
echo **3.) MANAGE EMULATIONSTATION THEMES
echo -------------------------------------------
echo **4.) RETURN TO MAIN MENU
echo ===========================================
CHOICE /C 1234 /N /T 60 /D 4 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==4 GOTO Main
IF ERRORLEVEL ==3 GOTO ThemeManager
IF ERRORLEVEL ==2 GOTO ManESCFG
IF ERRORLEVEL ==1 GOTO StartESVerCheck
::==============================================
::==============================================
:StartESVerCheck
::Starts checking Emulationstation's version for update. Removes the ESCheck folder to ensure comparison results are good.
cls
echo ====================================================
echo =                                                  =
echo =               CHECKING FOR UPDATES               =
echo =                                                  =
echo ====================================================
IF EXIST %tempDir%\ESCheck\ goto CleanESCheck
goto ESCheck
::==============================================
:CleanESCheck
rmdir %tempDir%\ESCheck /S /Q
goto ESCheck
::==============================================
:ESCheck
::Checks if emulationstation is installed. if not it prompts to install. if already installed downloads a small version of the latest update. Compares the downloaded exe with the installed exe. If different prompts to update
::Accomplishes this version compare by writing the file size of the current exe and the downloaded exe to two text files. Compares the strings in the text files. If they are the same then no update. If they are different then prompts for update.
::tried through WMIC checks, but version string is not included in the EXE :<
IF NOT EXIST %esDir%\emulationstation.exe goto UpdateESQN
mkdir %tempDir%\ESCheck
%toolsDir%\Wget\wget.exe -q https://github.com/jrassa/EmulationStation/releases/download/continuous-master/EmulationStation-Win32-no-deps.zip -O "%tempDir%\ESCheck\tempES.zip"
cls
%toolsDir%\7za\7za.exe x "%tempDir%\ESCheck\tempES.zip" -o"%tempDir%\ESCheck" -aoa > nul

for %%I in (%esDir%\emulationstation.exe) do echo %%~zI > %tempDir%\ESCheck\currentES.txt
for %%I in (%tempDir%\ESCheck\emulationstation.exe) do echo %%~zI > %tempDir%\ESCheck\newES.txt
cd /D %tempDir%\ESCheck
set /p currentES=<currentES.txt
set /p newES=<newES.txt
ping 127.0.0.1 -n 2 >nul
IF %currentES%==%newES% goto UpToDate
goto UpdateESQ
::==============================================
:UpdateESQ
::Prompts to update. Sends to Emulationstation installation (Newest available version)
cls

set /P c=An update is available. Would you like to update [Y/N]?
if /I "%c%" EQU "Y" goto UpdateES
if /I "%c%" EQU "N" goto cancelled
::==============================================
:UpdateESQN
::Lets the user know that emulationstation is not installed. Prompts for installation. (Newest available version)
cls

set /P c=EmulationStation not found. Would you like to install [Y/N]?
if /I "%c%" EQU "Y" goto UpdateES
if /I "%c%" EQU "N" goto cancelled
::==============================================
::==============================================
:updateES
::Backs up old installation
cls
echo =
echo ====================================================================
echo =                                                                  =
echo =    Backing up  EmulationStation  folder                          =
echo =                                                                  =
echo =    If this folder does not exist, it will be skipped             =
echo =                                                                  =
echo =                       please wait...                             =
echo =
%toolsDir%\7za\7za.exe a "%rp4winDir%\Backup\ES_Backup_%FormDate%_%FormTime%.zip" "%esDir%"
::Removes old emulationstation files
rmdir "%esDir%" /s /q
mkdir "%esDir%"
rmdir "%toolsDir%\ES-Batocera-Version" /s /q
mkdir "%toolsDir%\ES-Batocera-Version"
::Downloads the latest build of EmulationStation
cls
echo =
echo =
echo =
echo =
echo ==================================================================
echo =                                                  
echo = DOWNLOADING THE LATEST BUILD OF EMULATIONSTATION 
echo =                                                  
echo ==================================================================
echo =                                                                =
echo =         Download/Install:                                      =
echo =                                                                =
echo =              - EmulationStation (jrassa)                       =
echo =              - Carbon theme (RetroPie)                         =
echo =              - Slick City Lights theme (RetroHursty69)         =
echo =              - CosmicRise theme (RetroHursty69)                =
echo =                                                                =
echo =                                                                =
echo =         Also, Batocera versions of EmulationStation and        =
echo =               themes are provided in this directory:           =
echo =               %toolsDir%\ES-Batocera-Version
echo =               
echo =              - Batocera-EmulationStation  (fabricecaruso)      =
echo =              - Carbon theme  (fabricecaruso)                   =
echo =              - Mru5 theme    (kelvinator3300)                  =
echo =                                                                =
echo =                         please wait ...                        =
echo =                                                                =

%toolsDir%\Wget\wget.exe -q https://github.com/fabricecaruso/batocera-emulationstation/releases/download/continuous-master/EmulationStation-Win32.zip -O "%toolsDir%\ES-Batocera-Version\BES.zip"
ping 127.0.0.1 -n 3 > nul

::es-toolkit
mkdir "%tempDir%\EmulationStation"
%toolsDir%\Wget\wget.exe -q https://github.com/mattrixk/es-toolkit/archive/refs/tags/v1.2.zip -O "%tempDir%\estoolkit.zip"
ping 127.0.0.1 -n 3 > nul
%toolsDir%\7za\7za.exe x "%tempDir%\estoolkit.zip" -o"%tempDir%\EmulationStation" > nul
::delete unneeded portion of downloaded file
del "%tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\README.md"
rmdir "%tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\.emulationstation" /s /q
::moves batch file scripts to RP4Win\Emulationstation
move %tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\* %esDir%
::Cleans up downloaded zip and temp folder
del "%tempDir%\estoolkit.zip"
rmdir "%tempDir%\EmulationStation" /s /q
:: jdrassa emulationstation
%toolsDir%\Wget\wget.exe -q https://github.com/jrassa/EmulationStation/releases/download/continuous-master/EmulationStation-Win32.zip -O "%tempDir%\ES.zip"
:: Lines below are commented out -- for now.
:: Alternative - comment out the link above and then uncomment this link below when Jrassa's github fails to download
:: This link below pulls previously working build for Windows from AppVeyor site
::%toolsDir%\Wget\wget.exe -q https://ci.appveyor.com/api/buildjobs/ue3rq2weq0re3fqq/artifacts/EmulationStation-Win32.zip -O "%tempDir%\ES.zip"
:: https://ci.appveyor.com/project/jrassa/emulationstation
:: Lines above are commented out -- for now.
ping 127.0.0.1 -n 3 > nul
::Extracts to the RP4Win\Emulationstation directory
%toolsDir%\7za\7za.exe x "%tempDir%\ES.zip" -o"%esDir%" > nul
%toolsDir%\7za\7za.exe x "%toolsDir%\ES-Batocera-Version\BES.zip" -o"%toolsDir%\ES-Batocera-Version" > nul

cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
::Cleans up Downloaded zip
del "%tempDir%\ES.zip"
del "%toolsDir%\ES-Batocera-Version\BES.zip"
echo =
echo =
echo =
echo ============================================
echo =    Creating shortcut icons on Desktop    =
echo ============================================
::Deletes old shortcut
del "%USERPROFILE%\Desktop\*statio*.lnk
del "%rp4winDir%\*statio*.lnk"
::Makes two shortcuts on Desktop, to start RRP4Win in full-screen and windowed (EmulationStation icon)
::full screen
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%tempDir%\CreateShortcut.vbs"
echo sLinkFile = "%USERPROFILE%\Desktop\RP4Win.lnk" >> "%tempDir%\CreateShortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%tempDir%\CreateShortcut.vbs"
echo oLink.TargetPath = "%esDir%\Launch ES Fullscreen.bat" >> "%tempDir%\CreateShortcut.vbs"
echo oLink.WorkingDirectory = "%esDir%" >> "%tempDir%\CreateShortcut.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe" >> "%tempDir%\CreateShortcut.vbs"
echo oLink.Save >> "%tempDir%\CreateShortcut.vbs"
cscript "%tempDir%\CreateShortcut.vbs"
del "%tempDir%\CreateShortcut.vbs"
::windowed
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%tempDir%\CreateShortcut2.vbs"
echo sLinkFile = "%USERPROFILE%\Desktop\RP4Win Windowed.lnk" >> "%tempDir%\CreateShortcut2.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%tempDir%\CreateShortcut2.vbs"
echo oLink.TargetPath = "%esDir%\Launch ES Mid Size (1280x720).bat" >> "%tempDir%\CreateShortcut2.vbs"
echo oLink.WorkingDirectory = "%esDir%" >> "%tempDir%\CreateShortcut2.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe" >> "%tempDir%\CreateShortcut2.vbs"
echo oLink.Save >> "%tempDir%\CreateShortcut2.vbs"
cscript "%tempDir%\CreateShortcut2.vbs"
del "%tempDir%\CreateShortcut2.vbs"

::Makes two shortcuts in RRP4Win folder, to start RRP4Win in full-screen and windowed (EmulationStation icon)
::full screen
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%tempDir%\CreateShortcut.vbs"
echo sLinkFile = "%rp4winDir%\RP4Win.lnk" >> "%tempDir%\CreateShortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%tempDir%\CreateShortcut.vbs"
echo oLink.TargetPath = "%esDir%\Launch ES Fullscreen.bat" >> "%tempDir%\CreateShortcut.vbs"
echo oLink.WorkingDirectory = "%esDir%" >> "%tempDir%\CreateShortcut.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe" >> "%tempDir%\CreateShortcut.vbs"
echo oLink.Save >> "%tempDir%\CreateShortcut.vbs"
cscript "%tempDir%\CreateShortcut.vbs"
del "%tempDir%\CreateShortcut.vbs"
::windowed
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%tempDir%\CreateShortcut2.vbs"
echo sLinkFile = "%rp4winDir%\RP4Win Windowed.lnk" >> "%tempDir%\CreateShortcut2.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%tempDir%\CreateShortcut2.vbs"
echo oLink.TargetPath = "%esDir%\Launch ES Mid Size (1280x720).bat" >> "%tempDir%\CreateShortcut2.vbs"
echo oLink.WorkingDirectory = "%esDir%" >> "%tempDir%\CreateShortcut2.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe" >> "%tempDir%\CreateShortcut2.vbs"
echo oLink.Save >> "%tempDir%\CreateShortcut2.vbs"
cscript "%tempDir%\CreateShortcut2.vbs"
del "%tempDir%\CreateShortcut2.vbs"

if EXIST "%esDir%\emulationstation.exe" goto ESNewSucceed
goto ESNewFailed
::==============================================
:ESNewFailed
cls
echo ====================================================
echo =                                                  =
echo =  Current Builds of EmulationStation are Failing  =
echo =           Falling Back to Version 2.8.0          =
echo =                                                  =
echo ====================================================

rmdir "%esDir%" /s /q
mkdir "%esDir%"


::es-toolkit
mkdir "%tempDir%\EmulationStation"
%toolsDir%\Wget\wget.exe -q https://github.com/mattrixk/es-toolkit/archive/refs/tags/v1.2.zip -O "%tempDir%\estoolkit.zip"
ping 127.0.0.1 -n 3 > nul
%toolsDir%\7za\7za.exe x "%tempDir%\estoolkit.zip" -o"%tempDir%\EmulationStation" > nul
::delete unneeded portion of downloaded file
del "%tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\README.md"
rmdir "%tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\.emulationstation" /S /Q
::moves batch file scripts to RP4Win\Emulationstation
move %tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\* %esDir%
::Cleans up downloaded zip and temp folder
del "%tempDir%\estoolkit.zip"
rmdir "%tempDir%\EmulationStation" /S /Q

%toolsDir%\Wget\wget.exe -q https://sourceforge.net/projects/pinn-ironmine86/files/ES_2.8.0/EmulationStation.zip -O "%tempDir%\ES.zip"
ping 127.0.0.1 -n 3 > nul
::Extracts to the RP4Win\Emulationstation directory
%toolsDir%\7za\7za.exe x "%tempDir%\ES.zip" -o"%esDir%" > nul

cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
::Cleans up downloaded zip
del "%tempDir%\ES.zip"
echo =
echo =
echo =
echo ============================================
echo =    Creating shortcut icons on Desktop    =
echo ============================================
::Deletes old shortcut
del "%USERPROFILE%\Desktop\*statio*.lnk
del "%rp4winDir%\*statio*.lnk"

::Makes a shortcut on the desktop to Emulationstation called RP4Win (EmulationStation icon)
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%tempDir%\CreateShortcut.vbs"
echo sLinkFile = "%USERPROFILE%\Desktop\RP4Win.lnk" >> "%tempDir%\CreateShortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%tempDir%\CreateShortcut.vbs"
echo oLink.TargetPath = "%esDir%\Launch ES Fullscreen.bat" >> "%tempDir%\CreateShortcut.vbs"
echo oLink.WorkingDirectory = "%esDir%" >> "%tempDir%\CreateShortcut.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe" >> "%tempDir%\CreateShortcut.vbs"
echo oLink.Save >> "%tempDir%\CreateShortcut.vbs"
cscript "%tempDir%\CreateShortcut.vbs"
del "%tempDir%\CreateShortcut.vbs"

if EXIST "%esDir%\emulationstation.exe" goto ESNewSucceed
goto ESInstallTotalFailure
::==============================================
:ESNewSucceed
::Backs up entire themes folder to RP4Win's Temp folder
cls
echo =
echo ====================================================================
echo =                                                                  =
echo =    Backing up  ES Themes  folder                                 =
echo =                                                                  =
echo =    If this folder does not exist, it will be skipped             =
echo =                                                                  =
echo =                       please wait...                             =
echo =
::For now, this just makes a zipped backup of the folder to another location. if it exists.
%toolsDir%\7za\7za.exe a "%tempDir%\Backup\Backup_ES-Themes_%FormDate%_%FormTime%.zip" "%themesDir%\"

::Installs default Carbon theme
mkdir "%themesDir%"
cd /D "%themesDir%"
rmdir carbon /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/RetroPie/es-theme-carbon.git carbon

::Installs batocera themes
mkdir "%toolsDir%\ES-Batocera-Version\.emulationstation"
mkdir "%toolsDir%\ES-Batocera-Version\.emulationstation\themes"
cd /D "%toolsDir%\ES-Batocera-Version\.emulationstation\themes"
rmdir "%toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera" /S /Q
rmdir "%toolsDir%\ES-Batocera-Version\.emulationstation\themes\Mru5" /S /Q

%toolsDir%\git\bin\git.exe clone --recursive https://github.com/fabricecaruso/es-theme-carbon.git Carbon-Batocera
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/kelvinator3300/es-theme-mru5.git Mru5

::Fixes missing art (background, logos, etc.) for some systems
copy %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\background\gc.jpg %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\background\gamecube.jpg
copy %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\logos\gc-w.svg %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\logos\gamecube.svg
copy %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\logos\us\pce-cd.svg %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\logos\us\pcenginecd.svg

::Checks for temporary files created during automated installer selection
IF EXIST %tempDir%\BrandNewDef goto defaultESCFG
IF EXIST %tempDir%\BrandNewBlank goto blankESCFG
IF EXIST %tempDir%\BrandNewCus goto customESCFG
goto completed
::==============================================











::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection3
::Menu for managing RetroArch Updates, Core updates, and config.
cls
echo ===========================================
echo            Manage Retroarch                 
echo ===========================================
echo **1.) INSTALL RETROARCH v.%raVERSION%
echo -------------------------------------------
echo **2.) UPDATE/INSTALL RETROARCH TO THE LATEST NIGHTLY BUILD
echo -------------------------------------------
echo **3.) UPDATE RETROARCH CORES TO THE LATEST NIGHTLY BUILD
echo -------------------------------------------
echo **4.) GENERATE CLEAN RETROARCH.CFG
echo -------------------------------------------
echo **5.) Visit RetroArch website for versions  
echo -------------------------------------------
echo **6.) RETURN TO MAIN MENU
echo ===========================================
CHOICE /C 12345 /N /T 60 /D 5 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==6 GOTO Main
IF ERRORLEVEL ==5 GOTO VisitRAweb
IF ERRORLEVEL ==4 GOTO RACFG
IF ERRORLEVEL ==3 GOTO updatecores
IF ERRORLEVEL ==2 GOTO updateRAn
IF ERRORLEVEL ==1 GOTO updateRA
::==============================================


::==============================================
:VisitRAweb
::Review and/or manual install for  RetroArch and Cores
cls
echo =
echo ================================================
echo =                                              =
echo =    Visit or manual download / install:       =
echo =                                              =
echo =        RetroArch and Cores                   =
echo =                                              =
echo ================================================
echo = 
echo =   This will open RetroArch's website site in 
echo =   MS Edge web browser.
echo =
echo =     - Look for RetroArch.7z and RetroArch_Cores.7z in either:
echo =          - stable - version number - windows - x86_64
echo =          - nightly - windows - x86_64
echo = 
echo =     - Backup your existing RetroArch folder
echo =
echo =     - Download and extract RetroArch, Cores or both 7z files 
echo =         - rename 'RetroArch-Win64' to 'RetroArch' folder
echo =         - ensure 'cores' folder is inside 'RetroArch' folder
echo = 
echo =       'drive-letter:\RetroCake-Plus\RetroArch'
echo =
echo =   
echo =   NOTE:  If malware is detected, DO NOT INSTALL / USE !!!
echo =          Use other version that is free of malware  OR  skip this.
echo = 
echo =
pause>nul
start microsoft-edge:https://buildbot.libretro.com/
pause>nul
goto Selection3
::==============================================















::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection5
::Menu for managing ROM directories in both windows and es_systems.cfg. Can also share your ROM directories.
cls
echo ===========================================
echo      Manage rom Directories             
echo ===========================================
echo **1.) CREATE DEFAULT ROM DIRECTORIES (%romsDir%\SYSTEMNAME)
echo **2.) CREATE CUSTOM ROM DIRECTORIES
echo **3.) SHARE ROM DIRECTORIES
echo -------------------------------------------
echo **4.) OPEN ROMS FOLDER
echo -------------------------------------------
echo **5.) RETURN TO MAIN MENU
echo ===========================================
CHOICE /C 12345 /N /T 60 /D 5 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==5 GOTO Main
IF ERRORLEVEL ==4 GOTO OpenROMSNow
IF ERRORLEVEL ==3 GOTO DediShare
IF ERRORLEVEL ==2 GOTO CusRomDirSet
IF ERRORLEVEL ==1 GOTO DefaultRomFolders
::==============================================
:OpenROMSNow
start %romsDir%
goto Selection5
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection4
::Checks if the Emulator Folder is created. Creates if not.
cls 
IF EXIST %systemsDir% goto AdditionalEmu
mkdir %systemsDir%
goto AdditionalEmu
::==============================================
:AdditionalEmu
::Menu for managing additional programs
cls
echo ===========================================
echo      Manage Additional Programs             
echo ===========================================
echo **1.) INSTALL ALL ADDITIONAL EMULATORS
echo -------------------------------------------
echo **2.) INSTALL ATARI ST EMULATOR (Hatari)
echo -------------------------------------------
echo **3.) INSTALL BBC MICRO EMULATOR (BeebEm)
echo -------------------------------------------
echo **4.) INSTALL COCO\DRAGON32 EMULATOR (XRoar)
echo -------------------------------------------
echo **5.) INSTALL LASERDISK GAME EMULATOR (Daphne)
echo -------------------------------------------
echo **6.) INSTALL INTELLIVISION EMULATOR (jzIntv)
echo -------------------------------------------
echo **7.) INSTALL PS2 EMULATOR (PCSX2 1.4.0)
echo -------------------------------------------
echo **8.) INSTALL GAMECUBE EMULATOR (Dolphin 5.0)
echo -------------------------------------------
echo **9.) Page 2
echo ===========================================
CHOICE /C 123456789Q /N /T 30 /D Q /M "Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO Main
IF ERRORLEVEL ==9 GOTO EmuPage2
IF ERRORLEVEL ==8 GOTO DolphinEmu
IF ERRORLEVEL ==7 GOTO PCSX2
IF ERRORLEVEL ==6 GOTO jzIntv
IF ERRORLEVEL ==5 GOTO Daphne
IF ERRORLEVEL ==4 GOTO XRoar
IF ERRORLEVEL ==3 GOTO BeebEm
IF ERRORLEVEL ==2 GOTO Hatari
IF ERRORLEVEL ==1 GOTO InstallAllEmu
::==============================================
:EmuPage2
::Additional Emulators continued.
cls
echo ===========================================
echo      Manage Additional Programs             
echo ===========================================
echo **1.) INSTALL APPLE II EMULATOR (AppleWin)
echo -------------------------------------------
echo **2.) INSTALL COMMODORE 64 EMULATOR (WinVICE)
echo -------------------------------------------
echo **3.) INSTALL WII U EMULATOR (Cemu)
echo -------------------------------------------
echo **4.) RETURN TO MAIN MENU
echo ===========================================
CHOICE /C 1234 /N /T 30 /D 4 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==4 GOTO Main
IF ERRORLEVEL ==3 GOTO CemuEmu
IF ERRORLEVEL ==2 GOTO VICE
IF ERRORLEVEL ==1 GOTO AppleWin
::==============================================
:InstallAllEmu
::Secondary Emulator Folder check. May not be needed
IF EXIST %systemsDir% goto StartAllEmu
rmdir "%systemsDir%" /s /q
mkdir %systemsDir%
goto StartAllEmu
::==============================================
:StartAllEmu
::Creates a temporary file (tmp.txt) for the goto statements after each emulator is installed. Allows chaining emulator installation.
echo This file is temporary. You should never see it > %systemsDir%\tmp.txt
goto AppleWin
::==============================================
::=================================================================================================================================================================================================================================================================================================================
:BrandNewClean
::Removes temporary files used for guiding installation.
cls
del %tempDir%\BrandNewBlank /S /Q
del %tempDir%\BrandNewDef /S /Q
del %tempDir%\BrandNewCus /S /Q
goto completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection9
::Creates a batch file to pull the latest RP4Win.bat. Launches the new batch file that launches the new RP4Win.bat. Needed this separation as launching from inside this RP4Win.bat caused crashing issues.
goto NoFeat
cls
ping 127.0.0.1 -n 2 >nul
echo @echo off
echo del %toolsDir%\RP4Win.bat /S /Q > "%toolsDir%\Updater.bat"
echo %toolsDir%\git\bin\git.exe clone --depth=1 https://github.com/ironmine86/RP4Win.git %tempDir%\Script >> "%toolsDir%\Updater.bat"
echo xcopy %tempDir%\Script\RP4Win.bat %toolsDir%\ >> "%toolsDir%\Updater.bat"
echo rmdir %tempDir%\Script\ /S /Q >> "%toolsDir%\Updater.bat"
echo start %toolsDir%\RP4Win.bat >> "%toolsDir%\Updater.bat"
echo exit >> %toolsDir%\Updater.bat 
start %toolsDir%\Updater.bat
exit
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection6
::Menu for dedicated EmuBox Options/installation. Used for setting the machine to be installed as a standalone emulator box and not just an application
cls
echo ===========================================
echo      Manage Dedicated Emubox Settings             
echo ===========================================
echo **1.) SETUP ALL DEDICATED EMUBOX SETTINGS
echo   (Auto Start, Auto Login, Folder Shares, System Name to RP4Win)
echo -------------------------------------------
echo **2.) RP4Win AUTO START OPTIONS
echo -------------------------------------------
echo **3.) SETUP AUTOLOGIN
echo -------------------------------------------
echo **4.) SETUP RP4Win FOLDER SHARES
echo -------------------------------------------
echo **5.) SETUP SYSTEM NAME
echo -------------------------------------------
echo **6.) RETURN TO MAIN MENU
echo ===========================================
CHOICE /C 123456 /N /T 30 /D 6 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==6 GOTO Main
IF ERRORLEVEL ==5 GOTO DediHostnameMenu
IF ERRORLEVEL ==4 GOTO DediShareMenu
IF ERRORLEVEL ==3 GOTO AutoLogin
IF ERRORLEVEL ==2 GOTO AutoStartMenu
IF ERRORLEVEL ==1 GOTO FullDedi
::==============================================
:DediAsk
::Asks if this machine will be used as a dedicated emulator machine instead of installing as an application.
cls
set /P c=Is this system a dedicated Emulator Box [Y/N]?
if /I "%c%" EQU "Y" goto FullDedi
if /I "%c%" EQU "N" goto BrandNewClean
::==============================================
:FullDedi
::Creates a temporary file to guide the installation process through full dedicated setup.
cls
echo This file is temporary, you should never see it > %tempDir%\FullDedi.txt
IF EXIST %tempDir%\FullDedi.txt goto DediAutoStartSetup
goto crash
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:AutoStartMenu
::Menu for selecting if EmulationStation starts up when the PC logs in.
cls
echo ===========================================
echo      RP4Win AUTO START OPTIONS             
echo ===========================================
echo **1.) SETUP AUTOMATIC RP4Win LAUNCH ON LOGIN
echo -------------------------------------------
echo **2.) REMOVE AUTOMATIC RP4Win LAUNCH ON LOGIN
echo -------------------------------------------
echo **3.) RETURN TO DEDICATED EMUBOX MENU
echo ===========================================
CHOICE /C 123 /N /T 30 /D 3 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==3 GOTO Selection6
IF ERRORLEVEL ==2 GOTO DediAutoStartRemove
IF ERRORLEVEL ==1 GOTO DediAutoStartSetup
::==============================================
:DediAutoStartSetup
::Creates a batch file to launch Emulationstation. Creates a shortcut in the startup folder.
cls
echo ====================================================
echo =                                                  =
echo =      ADDING RP4Win TO AUTOSTART ON LOGIN         =
echo =                                                  =
echo ====================================================
cd /D "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
echo taskkill /im explorer.exe /f > "%toolsDir%\startES.bat"
echo "%esDir%\emulationstation.exe" >> "%toolsDir%\startES.bat"
del "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startES.lnk"
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%USERPROFILE%\CreateShortcut2.vbs"
echo sLinkFile = "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startES.lnk" >> "%USERPROFILE%\CreateShortcut2.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%USERPROFILE%\CreateShortcut2.vbs"
echo oLink.TargetPath = "%toolsDir%\startES.bat" >> "%USERPROFILE%\CreateShortcut2.vbs"
echo oLink.Save >> "%USERPROFILE%\CreateShortcut2.vbs"
cscript "%USERPROFILE%\CreateShortcut2.vbs"
del "%USERPROFILE%\CreateShortcut2.vbs"
IF EXIST %tempDir%\FullDedi.txt goto AutoLogin
goto completed
::==============================================
:DediAutoStartRemove
::Removes the shortcut in the startup folder. Disabling launching emulationstation on login.
cls
echo ====================================================
echo =                                                  =
echo =      REMOVING RP4Win AUTOSTART ON LOGIN       =
echo =                                                  =
echo ====================================================
del "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startES.lnk" /s /q
del %toolsDir%\startES.bat /a /q
goto completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:AutoLogin
::Guides the user through setting up Auto login. Tried to do this via registry edits, but it never worked properly.
cls
echo ==================================================================
echo =                                                                =
echo =                 PLEASE UNCHECK THE BOX LABELLED                =
echo = Users must enter a user name and password to use this computer =
echo =                      THEN PRESS OK OR APPLY                    =
echo =                                                                =
echo =                  PRESS ANY KEY WHEN FINISHED                   =
echo =                                                                =
echo ==================================================================
start netplwiz
pause > nul
IF EXIST %tempDir%\FullDedi.txt goto DediShare
goto completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:DediShareMenu
::Menu for Managing sharing of the RP4Win folders (ROMS, emulationstation config folder, RetroArch, and additional emulators.)
cls
echo ===========================================
echo      SETUP RP4Win FOLDER SHARES             
echo ===========================================
echo **1.) SETUP RP4Win SHARES WITH DEFAULT ROM DIRECTORY
echo -------------------------------------------
echo **2.) SETUP RP4Win SHARES WITH CUSTOM ROM DIRECTORY
echo -------------------------------------------
echo **3.) REMOVE RP4Win SHARES
echo -------------------------------------------
echo **4.) RETURN TO DEDICATED EMUBOX MENU
echo ===========================================
CHOICE /C 123 /N /T 30 /D 3 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==4 GOTO Selection6
IF ERRORLEVEL ==3 GOTO DediRemoveShares
IF ERRORLEVEL ==2 GOTO DediShare
IF ERRORLEVEL ==1 GOTO DediShare
::==============================================
:DediShare
::Shares all folders and sets permissions to Everyone R/W. Moves to ROM shares and checks if they are default or custom.
cls
net share BIOS=%RADir%\system /grant:everyone,full
net share Emulationstation="%USERPROFILE%\.emulationstation" /grant:everyone,full
net share Emulators=%systemsDir% /grant:everyone,full
IF EXIST %romsDir%\ goto RomShareDef
goto RomShareCus
::==============================================
:RomShareDef
::Shares default ROM dir.
net share ROMS=%romsDir% /grant:everyone,full
IF EXIST %tempDir%\FullDedi.txt goto DediHostnameDef
goto completed
::==============================================
:RomShareCus
::Shares Custom ROM dir.

set /p cusromdir="Enter Path for ROM Folder (default %romsDir%): "
net share ROMS=%cusromdir% /grant:everyone,full
IF EXIST %tempDir%\FullDedi.txt goto DediHostnameDef
goto completed
::==============================================
:DediRemoveShares
::Removes the shares created by this installer.
cls
net share BIOS /delete
net share EmulationStation /delete
net share ROMS /delete
net share Emulators /delete
goto completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:DediHostnameMenu
::Menu for managing the PC's hostname
cls
echo ===========================================
echo      SETUP SYSTEM NAME             
echo ===========================================
echo **1.) CHANGE PC NAME TO RP4Win
echo -------------------------------------------
echo **2.) CREATE CUSTOM PC NAME
echo -------------------------------------------
echo **3.) RETURN TO DEDICATED EMUBOX MENU
echo ===========================================
CHOICE /C 123 /N /T 30 /D 3 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==3 GOTO Selection6
IF ERRORLEVEL ==2 GOTO DediHostnameCus
IF ERRORLEVEL ==1 GOTO DediHostnameDef
::==============================================
:DediHostnameDef
::Sets the hostname to RP4Win.
cls
WMIC computersystem where caption='%COMPUTERNAME%' rename RP4Win
IF EXIST %tempDir%\FullDedi.txt goto FullDediClean
goto completed
::==============================================
:DediHostnameCus
::Allows the setting of custom hostname.
cls
set /p cushostname="Enter custom PC name: "
WMIC computersystem where caption='%COMPUTERNAME%' rename %cushostname%
goto completed
::==============================================
:FullDediClean
::Removes the temporary file used for performing all dedicated installation options.
cls
del %tempDir%\FullDedi.txt /s /q
goto completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::=================================================================================================================================================================================================================================================================================================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:ManESCFG
::Menu to manage es_systems.cfg
cls
echo ===========================================
echo           Manage es_systems.cfg
echo ===========================================
echo **1.) CREATE NEW ES_SYSTEMS.CFG WITH DEFAULT ROM PATH
echo %romsDir%\SYSTEM
echo (existing file backed-up to %tempDir%\Backup)
echo -------------------------------------------
echo **2.) CREATE NEW ES_SYSTEMS.CFG WITH CUSTOM ROM PATH
echo -------------------------------------------
echo **3.) CREATE NEW ES_SYSTEMS.CFG WITHOUT ROM PATHS
echo -------------------------------------------
echo **4.) EDIT ES_SYSTEMS.CFG
echo -------------------------------------------
echo **5.) RETURN TO EMULATIONSTATION MANAGER
echo ===========================================
CHOICE /C 12345 /N /T 15 /D 5 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==5 GOTO Selection2
IF ERRORLEVEL ==4 GOTO editES
IF ERRORLEVEL ==3 GOTO blankESCFG
IF ERRORLEVEL ==2 GOTO customESCFG
IF ERRORLEVEL ==1 GOTO defaultESCFG
::==============================================


















::=================================================================================================================================================================================================================================================================================================================
::==============================================
:blankESCFG
::Creates an es_systems.cfg without ROM directories incase you need/want something special (Not recommended as it's kinda poop to enter all the stuff manually.

::Backs up current es_systems.cfg
%toolsDir%\7za\7za.exe a "%USERPROFILE%\es_systems_%FormDate%_%FormTime%.zip" "%USERPROFILE%\.emulationstation\es_systems.cfg"

::Deletes old es_systems.cfg
del "%USERPROFILE%\.emulationstation\es_systems.cfg" /q

::Creates a new es_systems.cfg
cls
mkdir "%USERPROFILE%\.emulationstation"
echo ^<?xml version="1.0"?^> > "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo ^<systemList^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>nes^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo Entertainment System^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\nes^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .NES^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nes^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nes^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>fds^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Famicom Disk System^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\fds^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .fds .zip .NES .FDS .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>fds^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fds^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>snes^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Super Nintendo^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\snes^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .bin .smc .sfc .fig .swc .mgd .zip .7Z .BIN .SMC .SFC .FIG .SWC .MGD .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\snes9x2010_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>snes^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>snes^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>n64^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo 64^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\n64^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.z64 .n64 .v64 .Z64 .N64 .V64^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mupen64plus_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>n64^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>n64^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<name^>gc^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Gamecube^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<path^>C:\PATH\TO\ROM\FOLDER\gc^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.iso .gcz .gcn .ISO .GCZ .GCN^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Dolphin\DolphinWx.exe --exec="%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<platform^>gc^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<theme^>gc^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<name^>wii^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Wii^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<path^>C:\PATH\TO\ROM\FOLDER\wii^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.iso .ISO^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Dolphin\DolphinWx.exe --exec="%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<platform^>wii^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<theme^>wii^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<name^>wiiu^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Wiiu^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<path^>C:\PATH\TO\ROM\FOLDER\wiiu^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.rpx .RPX .iso .ISO .wud .WUD .wux .WUX^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Cemu\Cemu.exe -f -g "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<platform^>wiiu^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<theme^>wiiu^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>gameandwatch^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game & Watch^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\gameandwatch^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.mgw .MGW^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gw_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gameandwatch^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gameandwatch^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>gb^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\gb^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gb .zip .7Z .GB .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gb^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gb^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>virtualboy^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Virtualboy^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\virtualboy^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vb .zip .7Z .VB .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>virtualboy^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>virtualboy^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>gbc^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Color^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\gbc^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gbc .zip .7Z .GBC .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gbc^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gbc^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>gba^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Advance^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\gba^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gba .zip .7Z .GBA .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gpsp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gba^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gba^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>nds^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo DS^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\nds^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.zip .ZIP .nds .NDS^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\melonds_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nds^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nds^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>sg-1000^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega SG-1000^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\sg-1000^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.sg .bin .zip .SG .BIN .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sg-1000^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sg-1000^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>mastersystem^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Master System^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\mastersystem^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sms .bin .zip .7Z .SMS .BIN .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>mastersystem^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>mastersystem^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>megadrive^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Mega Drive^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\megadrive^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .smd .bin .gen .md .sg .zip .7Z .SMD .BIN .GEN .MD .SG .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>megadrive^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>megadrive^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>segacd^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Mega CD^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\segacd^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.iso .cue .ISO .CUE^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>segacd^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>segacd^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>sega32x^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega 32X^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\sega32x^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .32x .smd .bin .md .zip .7Z .32X .SMD .BIN .MD .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\picodrive_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sega32x^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sega32x^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>saturn^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Saturn^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\saturn^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .CUE .m3u .M3U .toc .TOC .CCD .ccd .^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_saturn_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>saturn^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>saturn^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>dreamcast^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Dreamcast^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\dreamcast^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.gdi .cdi .GDI .CDI .chd .CHD^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\reicast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dreamcast^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dreamcast^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>gamegear^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Gamegear^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\gamegear^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gg .bin .sms .zip .7Z .GG .BIN .SMS .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gamegear^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gamegear^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>psx^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\psx^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\pcsx_rearmed_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psx^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psx^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>ps2^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation 2^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\ps2^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\PCSX2\pcsx2.exe "%%ROM_RAW%%" --fullscreen^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ps2^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ps2^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>psp^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation Portable^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\psp^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cso .iso .pbp .CSO .ISO .PBP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ppsspp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psp^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psp^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari2600^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 2600^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atari2600^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a26 .bin .rom .zip .gz .7Z .A26 .BIN .ROM .ZIP .GZ^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\stella_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari2600^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari2600^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari800^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 800^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atari800^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bas .bin .car .com .xex .atr .xfd .dcm .atr.gz .xfd.gz .BAS .BIN .CAR .COM .XEX .ATR .XFD .DCM .ATR.GZ .XFD.GZ^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari800^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari800^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari5200^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 5200^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atari5200^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.a52 .bin .car .A52 .BIN .CAR^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari5200^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari5200^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari7800^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 7800 ProSystem^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atari7800^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a78 .bin .zip .7Z .A78 .BIN .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\prosystem_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari7800^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari7800^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarijaguar^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari Jaguar^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atarijaguar^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.j64 .jag .zip .J64 .JAG .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\virtualjaguar_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarijaguar^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarijaguar^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarilynx^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari Lynx^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atarilynx^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .lnx .zip .7Z .LNX .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\handy_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarilynx^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarilynx^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarist^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari ST^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atarist^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.st .stx .img .rom .raw .ipf .ctr .ST .STX .IMG .ROM .RAW .IPF .CTR^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\Hatari\Hatari.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarist^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarist^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>neogeo^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\neogeo^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>neogeo^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>neogeo^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>fba^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Final Burn Alpha^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\fba^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fba^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>ngp^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo Pocket^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\ngp^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ngp .zip .NGP .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_ngp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ngp^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ngp^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>ngpc^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo Pocket Color^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\ngpc^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ngc .zip .NGC .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_ngp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ngpc^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ngpc^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>mame-libretro^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Multiple Arcade Machine Emulator^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\mame^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.zip .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mame2003_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>mame^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>3do^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>3DO^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\3do^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.iso .ISO^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\4do_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>3do^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>3do^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>ags^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Adventure Game Studio^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\ags^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.exe .EXE^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ags_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ags^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ags^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>amiga^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Amiga^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\amiga^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.adf .ADF .zip .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\puae_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>amiga^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>amiga^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>amstradcpc^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Amstrad CPC^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\amstradcpc^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cdt .cpc .dsk .CDT .CPC .DSK^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\cap32_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>amstradcpc^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>amstradcpc^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>apple2^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Apple II^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\apple2^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.dsk .DSK^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%rp4winDir%\AppleWin\Applewin.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>apple2^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>apple2^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>bbcmicro^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari ST^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atarist^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ssd .dsd .ad .img .SSD .DSD .AD .IMG^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\BeebEm\BeebEm.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>bbcmicro^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>bbcmicro^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>c64^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Commodore 64^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\c64^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.crt .d64 .g64 .t64 .tap .x64 .zip .prg .CRT .D64 .G64 .T64 .TAP .X64 .ZIP .PRG^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\WinVICE\x64.exe -fullscreen "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>c64^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>c64^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>coco^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>CoCo^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\coco^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>coco^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>coco^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>coleco^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ColecoVision^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\colecovision^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bin .col .rom .zip .BIN .COL .ROM .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>colecovision^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>colecovision^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>daphne^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Daphne^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\daphne^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.daphne .DAPHNE^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\Daphne\daphne.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>daphne^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>daphne^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>dragon32^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Dragon 32^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\dragon32^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dragon32^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dragon32^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>intellivision^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Intellivision^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\intellivision^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.int .bin .INT .BIN^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\jzIntv\bin\jzIntv.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>intellivision^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>intellivision^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>msx^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>MSX^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\msx^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.rom .mx1 .mx2 .col .dsk .zip .ROM .MX1 .MX2 .COL .DSK .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>msx^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>msx^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>pcengine^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PC Engine^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\pcengine^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .pce .ccd .cue .zip .7Z .PCE .CCD .CUE .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_pce_fast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>pcengine^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>pcengine^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>vectrex^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Vectrex^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\vectrex^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vec .gam .bin .zip .7Z .VEC .GAM .BIN .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>vectrex^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>vectrex^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>zxspectrum^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ZX Spectrum^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\zxspectrum^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sh .sna .szx .z80 .tap .tzx .gz .udi .mgt .img .trd .scl .dsk .zip .7Z .SH .SNA .SZX .Z80 .TAP .TZX .GZ .UDI .MGT .IMG .TRD .SCL .DSK .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fuse_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>zxspectrum^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>zxspectrum^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo ^</systemList^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
IF EXIST %tempDir%\BrandNewBlank goto updateRA
goto completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:defaultESCFG
::Creates an es_systems.cfg using the default ROM directory %romsDir%

::Backs up current es_systems.cfg
%toolsDir%\7za\7za.exe a "%tempDir%\Backup\Backup_es_systems-config_%FormDate%_%FormTime%.zip" "%esDir%\.emulationstation\es_systems.cfg"

::Deletes old es_systems.cfg
del "%esDir%\.emulationstation\es_systems.cfg" /q

::Creates a new es_systems.cfg
cls
mkdir "%esDir%\.emulationstation"
echo ^<?xml version="1.0"?^> > "%esDir%\.emulationstation\es_systems.cfg"

echo ^<systemList^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>nes^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo Entertainment System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\nes^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .NES^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nes^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nes^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>fds^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Famicom Disk System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\fds^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .fds .zip .NES .FDS .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>fds^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fds^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>snes^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Super Nintendo^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\snes^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .bin .smc .sfc .fig .swc .mgd .zip .7Z .BIN .SMC .SFC .FIG .SWC .MGD .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\snes9x2010_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>snes^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>snes^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>n64^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo 64^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\n64^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.z64 .n64 .v64 .Z64 .N64 .V64^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mupen64plus_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>n64^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>n64^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<name^>gc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Gamecube^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<path^>%romsDir%\gc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.iso .gcz .gcn .ISO .GCZ .GCN^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Dolphin\DolphinWx.exe --exec="%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<platform^>gc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<theme^>gc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<name^>wii^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Wii^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<path^>%romsDir%\wii^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.iso .ISO^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Dolphin\DolphinWx.exe --exec="%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<platform^>wii^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<theme^>wii^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<name^>wiiu^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Wiiu^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<path^>%romsDir%\wiiu^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.rpx .RPX .iso .ISO .wud .WUD .wux .WUX^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Cemu\Cemu.exe -f -g "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<platform^>wiiu^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<theme^>wiiu^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gameandwatch^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game & Watch^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\gameandwatch^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.mgw .MGW^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gw_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gameandwatch^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gameandwatch^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gb^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\gb^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gb .zip .7Z .GB .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gb^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gb^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>virtualboy^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Virtualboy^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\virtualboy^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vb .zip .7Z .VB .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>virtualboy^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>virtualboy^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gbc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Color^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\gbc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gbc .zip .7Z .GBC .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gbc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gbc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gba^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Advance^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\gba^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gba .zip .7Z .GBA .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gpsp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gba^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gba^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>nds^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo DS^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\nds^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.zip .ZIP .nds .NDS^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\melonds_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nds^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nds^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>sg-1000^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega SG-1000^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\sg-1000^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.sg .bin .zip .SG .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sg-1000^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sg-1000^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>mastersystem^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Master System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\mastersystem^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sms .bin .zip .7Z .SMS .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>mastersystem^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>mastersystem^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>megadrive^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Mega Drive^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\megadrive^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .smd .bin .gen .md .sg .zip .7Z .SMD .BIN .GEN .MD .SG .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>megadrive^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>megadrive^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>segacd^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Mega CD^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\segacd^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.iso .cue .ISO .CUE^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>segacd^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>segacd^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>sega32x^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega 32X^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\sega32x^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .32x .smd .bin .md .zip .7Z .32X .SMD .BIN .MD .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\picodrive_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sega32x^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sega32x^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>saturn^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Saturn^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\saturn^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .CUE .ccd .CCD .chd .CHD .toc .TOC .m3u .M3U^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_saturn_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>saturn^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>saturn^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>dreamcast^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Dreamcast^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\dreamcast^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.gdi .cdi .GDI .CDI .chd .CHD^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\reicast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dreamcast^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dreamcast^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gamegear^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Gamegear^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\gamegear^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gg .bin .sms .zip .7Z .GG .BIN .SMS .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gamegear^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gamegear^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>psx^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\psx^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\pcsx_rearmed_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psx^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psx^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ps2^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation 2^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\ps2^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\PCSX2\pcsx2.exe "%%ROM_RAW%%" --fullscreen^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ps2^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ps2^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>psp^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation Portable^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\psp^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cso .iso .pbp .CSO .ISO .PBP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ppsspp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psp^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psp^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari2600^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 2600^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\atari2600^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a26 .bin .rom .zip .gz .7Z .A26 .BIN .ROM .ZIP .GZ^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\stella_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari2600^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari2600^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari800^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 800^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\atari800^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bas .bin .car .com .xex .atr .xfd .dcm .atr.gz .xfd.gz .BAS .BIN .CAR .COM .XEX .ATR .XFD .DCM .ATR.GZ .XFD.GZ^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari800^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari800^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari5200^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 5200^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\atari5200^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.a52 .bin .car .A52 .BIN .CAR^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari5200^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari5200^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari7800^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 7800 ProSystem^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\atari7800^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a78 .bin .zip .7Z .A78 .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\prosystem_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari7800^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari7800^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarijaguar^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari Jaguar^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\atarijaguar^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.j64 .jag .zip .J64 .JAG .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\virtualjaguar_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarijaguar^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarijaguar^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarilynx^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari Lynx^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\atarilynx^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .lnx .zip .7Z .LNX .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\handy_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarilynx^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarilynx^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarist^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari ST^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\atarist^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.st .stx .img .rom .raw .ipf .ctr .ST .STX .IMG .ROM .RAW .IPF .CTR^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\Hatari\Hatari.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarist^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarist^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>neogeo^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\neogeo^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>neogeo^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>neogeo^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>fba^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Final Burn Alpha^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\fba^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fba^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ngp^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo Pocket^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\ngp^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ngp .zip .NGP .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_ngp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ngp^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ngp^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ngpc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo Pocket Color^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\ngpc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ngc .zip .NGC .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_ngp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ngpc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ngpc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>mame-libretro^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Multiple Arcade Machine Emulator^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\mame^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.zip .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mame2003_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>mame^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>3do^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>3DO^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\3do^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.iso .ISO^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\4do_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>3do^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>3do^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ags^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Adventure Game Studio^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\ags^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.exe .EXE^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ags_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ags^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ags^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>amiga^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Amiga^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\amiga^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.adf .ADF .zip .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\puae_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>amiga^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>amiga^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>amstradcpc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Amstrad CPC^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\amstradcpc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cdt .cpc .dsk .CDT .CPC .DSK^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\cap32_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>amstradcpc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>amstradcpc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>apple2^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Apple II^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\apple2^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.dsk .DSK^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%rp4winDir%\AppleWin\Applewin.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>apple2^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>apple2^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>bbcmicro^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari ST^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\atarist^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ssd .dsd .ad .img .SSD .DSD .AD .IMG^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\BeebEm\BeebEm.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>bbcmicro^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>bbcmicro^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>c64^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Commodore 64^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\c64^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.crt .d64 .g64 .t64 .tap .x64 .zip .prg .CRT .D64 .G64 .T64 .TAP .X64 .ZIP .PRG^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\WinVICE\x64.exe -fullscreen "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>c64^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>c64^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>coco^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>CoCo^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\coco^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>coco^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>coco^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>coleco^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ColecoVision^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\colecovision^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bin .col .rom .zip .BIN .COL .ROM .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>colecovision^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>colecovision^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>daphne^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Daphne^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\daphne^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.daphne .DAPHNE^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\Daphne\daphne.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>daphne^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>daphne^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>dragon32^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Dragon 32^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\dragon32^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dragon32^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dragon32^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>intellivision^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Intellivision^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\intellivision^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.int .bin .INT .BIN^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\jzIntv\bin\jzIntv.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>intellivision^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>intellivision^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>msx^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>MSX^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\msx^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.rom .mx1 .mx2 .col .dsk .zip .ROM .MX1 .MX2 .COL .DSK .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>msx^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>msx^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>pcengine^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PC Engine^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\pcengine^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .pce .ccd .cue .zip .7Z .PCE .CCD .CUE .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_pce_fast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>pcengine^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>pcengine^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>vectrex^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Vectrex^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\vectrex^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vec .gam .bin .zip .7Z .VEC .GAM .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>vectrex^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>vectrex^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>zxspectrum^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ZX Spectrum^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\zxspectrum^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sh .sna .szx .z80 .tap .tzx .gz .udi .mgt .img .trd .scl .dsk .zip .7Z .SH .SNA .SZX .Z80 .TAP .TZX .GZ .UDI .MGT .IMG .TRD .SCL .DSK .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fuse_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>zxspectrum^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>zxspectrum^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo ^</systemList^> >> "%esDir%\.emulationstation\es_systems.cfg"

IF EXIST %tempDir%\BrandNewDef goto DefaultRomFolders
goto completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:customESCFG
::Creates es_systems.cfg using the custom ROM directory specified during automated installation or when managing ROM directories.
cls

set /P cusromdir="Enter Path for ROM Folder (default %romsDir%): "

echo ^<?xml version="1.0"?^> > "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo ^<systemList^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>nes^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo Entertainment System^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\nes^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .NES^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nes^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nes^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>fds^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Famicom Disk System^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\fds^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .fds .zip .NES .FDS .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>fds^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fds^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>snes^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Super Nintendo^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\snes^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .bin .smc .sfc .fig .swc .mgd .zip .7Z .BIN .SMC .SFC .FIG .SWC .MGD .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\snes9x2010_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>snes^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>snes^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>n64^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo 64^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\n64^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.z64 .n64 .v64 .Z64 .N64 .V64^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mupen64plus_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>n64^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>n64^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<name^>gc^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Gamecube^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<path^>%cusromdir%\gc^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.iso .gcz .gcn .ISO .GCZ .GCN^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Dolphin\DolphinWx.exe --exec="%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<platform^>gc^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<theme^>gc^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<name^>wii^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Wii^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<path^>%cusromdir%\wii^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.iso .ISO^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Dolphin\DolphinWx.exe --exec="%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<platform^>wii^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<theme^>wii^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<name^>wiiu^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Wiiu^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<path^>%cusromdir%\wiiu^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.rpx .RPX .iso .ISO .wud .WUD .wux .WUX^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Cemu\Cemu.exe -f -g "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<platform^>wiiu^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo 	^<theme^>wiiu^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>gameandwatch^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game & Watch^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\gameandwatch^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.mgw .MGW^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gw_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gameandwatch^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gameandwatch^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>gb^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\gb^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gb .zip .7Z .GB .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gb^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gb^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>virtualboy^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Virtualboy^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\virtualboy^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vb .zip .7Z .VB .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>virtualboy^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>virtualboy^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>gbc^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Color^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\gbc^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gbc .zip .7Z .GBC .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gbc^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gbc^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>gba^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Advance^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\gba^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gba .zip .7Z .GBA .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gpsp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gba^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gba^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>nds^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo DS^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\nds^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.zip .ZIP .nds .NDS^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\melonds_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nds^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nds^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>sg-1000^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega SG-1000^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\sg-1000^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.sg .bin .zip .SG .BIN .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sg-1000^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sg-1000^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>mastersystem^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Master System^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\mastersystem^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sms .bin .zip .7Z .SMS .BIN .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>mastersystem^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>mastersystem^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>megadrive^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Mega Drive^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\megadrive^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .smd .bin .gen .md .sg .zip .7Z .SMD .BIN .GEN .MD .SG .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>megadrive^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>megadrive^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>segacd^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Mega CD^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\segacd^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.iso .cue .ISO .CUE^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>segacd^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>segacd^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>sega32x^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega 32X^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\sega32x^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .32x .smd .bin .md .zip .7Z .32X .SMD .BIN .MD .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\picodrive_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sega32x^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sega32x^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>saturn^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Saturn^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\saturn^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .CUE .ccd .CCD .chd .CHD .toc .TOC .m3u .M3U^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_saturn_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>saturn^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>saturn^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>dreamcast^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Dreamcast^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\dreamcast^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.gdi .cdi .GDI .CDI .chd .CHD^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\reicast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dreamcast^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dreamcast^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>gamegear^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Gamegear^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\gamegear^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gg .bin .sms .zip .7Z .GG .BIN .SMS .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gamegear^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gamegear^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>psx^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\psx^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\pcsx_rearmed_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psx^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psx^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>ps2^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation 2^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\ps2^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\PCSX2\pcsx2.exe "%%ROM_RAW%%" --fullscreen^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ps2^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ps2^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>psp^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation Portable^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\psp^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cso .iso .pbp .CSO .ISO .PBP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ppsspp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psp^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psp^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari2600^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 2600^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atari2600^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a26 .bin .rom .zip .gz .7Z .A26 .BIN .ROM .ZIP .GZ^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\stella_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari2600^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari2600^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari800^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 800^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atari800^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bas .bin .car .com .xex .atr .xfd .dcm .atr.gz .xfd.gz .BAS .BIN .CAR .COM .XEX .ATR .XFD .DCM .ATR.GZ .XFD.GZ^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari800^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari800^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari5200^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 5200^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atari5200^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.a52 .bin .car .A52 .BIN .CAR^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari5200^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari5200^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari7800^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 7800 ProSystem^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atari7800^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a78 .bin .zip .7Z .A78 .BIN .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\prosystem_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari7800^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari7800^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarijaguar^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari Jaguar^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atarijaguar^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.j64 .jag .zip .J64 .JAG .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\virtualjaguar_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarijaguar^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarijaguar^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarilynx^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari Lynx^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atarilynx^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .lnx .zip .7Z .LNX .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\handy_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarilynx^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarilynx^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarist^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari ST^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atarist^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.st .stx .img .rom .raw .ipf .ctr .ST .STX .IMG .ROM .RAW .IPF .CTR^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\Hatari\Hatari.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarist^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarist^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>neogeo^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\neogeo^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>neogeo^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>neogeo^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>fba^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Final Burn Alpha^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\fba^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fba^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>ngp^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo Pocket^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\ngp^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ngp .zip .NGP .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_ngp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ngp^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ngp^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>ngpc^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo Pocket Color^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\ngpc^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ngc .zip .NGC .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_ngp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ngpc^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ngpc^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>mame-libretro^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Multiple Arcade Machine Emulator^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\mame^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.zip .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mame2003_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>mame^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>3do^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>3DO^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\3do^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.iso .ISO^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\4do_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>3do^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>3do^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>ags^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Adventure Game Studio^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\ags^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.exe .EXE^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ags_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ags^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ags^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>amiga^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Amiga^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\amiga^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.adf .ADF .zip .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\puae_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>amiga^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>amiga^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>amstradcpc^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Amstrad CPC^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\amstradcpc^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cdt .cpc .dsk .CDT .CPC .DSK^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\cap32_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>amstradcpc^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>amstradcpc^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>apple2^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Apple II^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\apple2^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.dsk .DSK^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%rp4winDir%\AppleWin\Applewin.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>apple2^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>apple2^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>bbcmicro^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari ST^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atarist^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ssd .dsd .ad .img .SSD .DSD .AD .IMG^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\BeebEm\BeebEm.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>bbcmicro^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>bbcmicro^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>c64^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Commodore 64^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\c64^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.crt .d64 .g64 .t64 .tap .x64 .zip .prg .CRT .D64 .G64 .T64 .TAP .X64 .ZIP .PRG^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\WinVICE\x64.exe -fullscreen "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>c64^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>c64^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>coco^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>CoCo^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\coco^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>coco^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>coco^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>coleco^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ColecoVision^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\colecovision^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bin .col .rom .zip .BIN .COL .ROM .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>colecovision^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>colecovision^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>daphne^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Daphne^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\daphne^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.daphne .DAPHNE^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\Daphne\daphne.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>daphne^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>daphne^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>dragon32^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Dragon 32^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\dragon32^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dragon32^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dragon32^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>intellivision^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Intellivision^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\intellivision^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.int .bin .INT .BIN^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\jzIntv\bin\jzIntv.exe "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>intellivision^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>intellivision^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>msx^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>MSX^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\msx^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.rom .mx1 .mx2 .col .dsk .zip .ROM .MX1 .MX2 .COL .DSK .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>msx^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>msx^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>pcengine^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PC Engine^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\pcengine^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .pce .ccd .cue .zip .7Z .PCE .CCD .CUE .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_pce_fast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>pcengine^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>pcengine^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>vectrex^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Vectrex^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\vectrex^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vec .gam .bin .zip .7Z .VEC .GAM .BIN .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>vectrex^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>vectrex^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<name^>zxspectrum^</name^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ZX Spectrum^</fullname^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\zxspectrum^</path^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sh .sna .szx .z80 .tap .tzx .gz .udi .mgt .img .trd .scl .dsk .zip .7Z .SH .SNA .SZX .Z80 .TAP .TZX .GZ .UDI .MGT .IMG .TRD .SCL .DSK .ZIP^</extension^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fuse_libretro.dll "%%ROM_RAW%%"^</command^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<platform^>zxspectrum^</platform^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo     ^<theme^>zxspectrum^</theme^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
echo ^</systemList^> >> "%USERPROFILE%\.emulationstation\es_systems.cfg"
IF EXIST %tempDir%\BrandNewCus goto CustomRomFolders
goto completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:editES
cls
notepad %esDir%\.emulationstation\es_systems.cfg
goto ManESCFG
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:DefaultRomFolders
::Creates default ROM folders in %romsDir%
cls
mkdir %romsDir%\3do
mkdir %romsDir%\ags
mkdir %romsDir%\amiga
mkdir %romsDir%\amstradcpc
mkdir %romsDir%\apple2
mkdir %romsDir%\atari2600
mkdir %romsDir%\atari5200
mkdir %romsDir%\atari7800
mkdir %romsDir%\atari800
mkdir %romsDir%\atarijaguar
mkdir %romsDir%\atarilynx
mkdir %romsDir%\atarist
mkdir %romsDir%\bbcmicro
mkdir %romsDir%\c64
mkdir %romsDir%\coco
mkdir %romsDir%\colecovision
mkdir %romsDir%\daphne
mkdir %romsDir%\dragon32
mkdir %romsDir%\dreamcast
mkdir %romsDir%\fba
mkdir %romsDir%\fds
mkdir %romsDir%\gameandwatch
mkdir %romsDir%\gamegear
mkdir %romsDir%\gb
mkdir %romsDir%\gba
mkdir %romsDir%\gbc
mkdir %romsDir%\gc
mkdir %romsDir%\intellivision
mkdir %romsDir%\mame
mkdir %romsDir%\mastersystem
mkdir %romsDir%\mega32x
mkdir %romsDir%\mega-cd
mkdir %romsDir%\megadrive
mkdir %romsDir%\msx
mkdir %romsDir%\mvs
mkdir %romsDir%\n64
mkdir %romsDir%\nds
mkdir %romsDir%\neogeo
mkdir %romsDir%\nes
mkdir %romsDir%\ngp
mkdir %romsDir%\ngpc
mkdir %romsDir%\pcengine
mkdir %romsDir%\ps2
mkdir %romsDir%\psp
mkdir %romsDir%\psx
mkdir %romsDir%\saturn
mkdir %romsDir%\sega32x
mkdir %romsDir%\segacd
mkdir %romsDir%\sfc
mkdir %romsDir%\sg-1000
mkdir %romsDir%\snes
mkdir %romsDir%\vectrex
mkdir %romsDir%\virtualboy
mkdir %romsDir%\wii
mkdir %romsDir%\wiiu
mkdir %romsDir%\zxspectrum
:: Opens file location
start %romsDir%
IF EXIST %tempDir%\BrandNewDef goto updateRA
goto completed
::==============================================
:CusRomDirSet
::Sets Custom ROM Directory via user input
set /p cusromdir="Enter Path for ROM Folder (default %romsDir%): "
goto CustomRomFolders
::==============================================
:CustomRomFolders
::Creates ROM folders based on variable set bu user above
cls
mkdir %cusromdir%\3do
mkdir %cusromdir%\ags
mkdir %cusromdir%\amiga
mkdir %cusromdir%\amstradcpc
mkdir %cusromdir%\apple2
mkdir %cusromdir%\atari2600
mkdir %cusromdir%\atari5200
mkdir %cusromdir%\atari7800
mkdir %cusromdir%\atari800
mkdir %cusromdir%\atarijaguar
mkdir %cusromdir%\atarilynx
mkdir %cusromdir%\atarist
mkdir %cusromdir%\bbcmicro
mkdir %cusromdir%\c64
mkdir %cusromdir%\coco
mkdir %cusromdir%\colecovision
mkdir %cusromdir%\daphne
mkdir %cusromdir%\dragon32
mkdir %cusromdir%\dreamcast
mkdir %cusromdir%\fba
mkdir %cusromdir%\fds
mkdir %cusromdir%\gameandwatch
mkdir %cusromdir%\gamegear
mkdir %cusromdir%\gb
mkdir %cusromdir%\gba
mkdir %cusromdir%\gbc
mkdir %cusromdir%\gc
mkdir %cusromdir%\intellivision
mkdir %cusromdir%\mame
mkdir %cusromdir%\mastersystem
mkdir %cusromdir%\mega32x
mkdir %cusromdir%\mega-cd
mkdir %cusromdir%\megadrive
mkdir %cusromdir%\msx
mkdir %cusromdir%\mvs
mkdir %cusromdir%\n64
mkdir %cusromdir%\nds
mkdir %cusromdir%\neogeo
mkdir %cusromdir%\nes
mkdir %cusromdir%\ngp
mkdir %cusromdir%\ngpc
mkdir %cusromdir%\pcengine
mkdir %cusromdir%\ps2
mkdir %cusromdir%\psp
mkdir %cusromdir%\psx
mkdir %cusromdir%\saturn
mkdir %cusromdir%\sega32x
mkdir %cusromdir%\segacd
mkdir %cusromdir%\sfc
mkdir %cusromdir%\sg-1000
mkdir %cusromdir%\snes
mkdir %cusromdir%\vectrex
mkdir %cusromdir%\virtualboy
mkdir %cusromdir%\wii
mkdir %cusromdir%\wiiu
mkdir %cusromdir%\zxspectrum
:: Opens file location
start %cusromdir%
IF EXIST %tempDir%\BrandNewCus goto updateRA
goto completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:updateRA
::RetroArch Updater. Archtecture check (x86 or x86_64)
cls
mkdir %tempDir%\cores
cls
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto x64RA
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto x86RA
	)

:x64RA
::Installs RetroArch 1.9.0 to RP4Win\RetroArch. Cleans up all downloaded files when done. 64 bit
echo =================================================================
echo =                                                               =
echo =        Downloading RetroArch. This will take some time        =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/stable/1.9.0/windows/x86_64/RetroArch.7z -o"%tempDir%\RetroArch_x64.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x64.zip" -o"%raDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 4 >nul
del "%tempDir%\RetroArch_x64.zip" /q
goto RACFG

:x86RA
::Installs RetroArch 1.9.0 to RP4Win\RetroArch. Cleans up all downloaded files when done. 32 bit
echo =================================================================
echo =                                                               =
echo =        Downloading RetroArch. This will take some time        =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/stable/1.9.0/windows/x86/RetroArch.7z -o"%tempDir%\RetroArch_x86.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x86.zip" -o"%raDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 4 >nul
del "%tempDir%\RetroArch_x86.7z" /q
goto RACFG
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:updateRAn
cls
mkdir %tempDir%\cores
cls
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto x64RAn
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto x86RAn
	)

:x64RAn
::Installs RetroArch to RP4Win\RetroArch. Cleans up all downloaded files when done. x64 version of latest nightly
echo =================================================================
echo =                                                               =
echo =        Downloading RetroArch. This will take some time        =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/nightly/windows/x86_64/RetroArch.7z -O "%tempDir%\RetroArch_x64.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x64.zip" -o"%raDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 4 >nul
del "%tempDir%\RetroArch_x64.7z" /q
goto completed

:x86RAn
::Installs RetroArch to RP4Win\RetroArch. Cleans up all downloaded files when done. 32 bit version of the latest nightly
echo =================================================================
echo =                                                               =
echo =        Downloading RetroArch. This will take some time        =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/nightly/windows/x86/RetroArch.7z -O "%tempDir%\RetroArch_x86.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x86.zip" -o"%raDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 4 >nul
del "%tempDir%\RetroArch_x86.7z" /q
goto completed
::==============================================
:RACFG
::Generates a retroarch config file. 99% default. Adds the start+select opening of the retroarch menu in game. RetroPie accomplishes this by using custom mapping with RetroPad, but I found this to be simpler.
echo config_save_on_exit = "true"> %RADir%\retroarch.cfg
echo core_updater_buildbot_url = "http://buildbot.libretro.com/nightly/windows/x86_64/latest/">> %RADir%\retroarch.cfg
echo core_updater_buildbot_assets_url = "http://buildbot.libretro.com/assets/">> %RADir%\retroarch.cfg
echo libretro_directory = ":\cores">> %RADir%\retroarch.cfg
echo libretro_info_path = ":\info">> %RADir%\retroarch.cfg
echo content_database_path = ":\database\rdb">> %RADir%\retroarch.cfg
echo cheat_database_path = ":\cheats">> %RADir%\retroarch.cfg
echo content_history_path = ":\content_history.lpl">> %RADir%\retroarch.cfg
echo content_favorites_path = ":\content_favorites.lpl">> %RADir%\retroarch.cfg
echo content_music_history_path = ":\content_music_history.lpl">> %RADir%\retroarch.cfg
echo content_video_history_path = ":\content_video_history.lpl">> %RADir%\retroarch.cfg
echo content_image_history_path = ":\content_image_history.lpl">> %RADir%\retroarch.cfg
echo cursor_directory = ":\database\cursors">> %RADir%\retroarch.cfg
echo screenshot_directory = ":\screenshots">> %RADir%\retroarch.cfg
echo system_directory = ":\system">> %RADir%\retroarch.cfg
echo input_remapping_directory = ":\config\remaps">> %RADir%\retroarch.cfg
echo video_shader_dir = ":\shaders">> %RADir%\retroarch.cfg
echo video_filter_dir = ":\filters\video">> %RADir%\retroarch.cfg
echo core_assets_directory = ":\downloads">> %RADir%\retroarch.cfg
echo assets_directory = ":\assets">> %RADir%\retroarch.cfg
echo dynamic_wallpapers_directory = ":\assets\wallpapers">> %RADir%\retroarch.cfg
echo thumbnails_directory = ":\thumbnails">> %RADir%\retroarch.cfg
echo playlist_directory = ":\playlists">> %RADir%\retroarch.cfg
echo joypad_autoconfig_dir = ":\autoconfig">> %RADir%\retroarch.cfg
echo audio_filter_dir = ":\filters\audio">> %RADir%\retroarch.cfg
echo savefile_directory = ":\saves">> %RADir%\retroarch.cfg
echo savestate_directory = ":\states">> %RADir%\retroarch.cfg
echo rgui_browser_directory = "default">> %RADir%\retroarch.cfg
echo rgui_config_directory = ":\config">> %RADir%\retroarch.cfg
echo overlay_directory = ":\overlays">> %RADir%\retroarch.cfg
echo screenshot_directory = ":\screenshots">> %RADir%\retroarch.cfg
echo video_driver = "gl">> %RADir%\retroarch.cfg
echo record_driver = "ffmpeg">> %RADir%\retroarch.cfg
echo camera_driver = "null">> %RADir%\retroarch.cfg
echo wifi_driver = "null">> %RADir%\retroarch.cfg
echo location_driver = "null">> %RADir%\retroarch.cfg
echo menu_driver = "xmb">> %RADir%\retroarch.cfg
echo audio_driver = "xaudio">> %RADir%\retroarch.cfg
echo audio_resampler = "sinc">> %RADir%\retroarch.cfg
echo input_driver = "dinput">> %RADir%\retroarch.cfg
echo input_joypad_driver = "xinput">> %RADir%\retroarch.cfg
echo video_aspect_ratio = "-1.000000">> %RADir%\retroarch.cfg
echo video_scale = "3.000000">> %RADir%\retroarch.cfg
echo video_refresh_rate = "60.000027">> %RADir%\retroarch.cfg
echo audio_rate_control_delta = "0.005000">> %RADir%\retroarch.cfg
echo audio_max_timing_skew = "0.050000">> %RADir%\retroarch.cfg
echo audio_volume = "0.000000">> %RADir%\retroarch.cfg
echo audio_mixer_volume = "0.000000">> %RADir%\retroarch.cfg
echo input_overlay_opacity = "0.700000">> %RADir%\retroarch.cfg
echo input_overlay_scale = "1.000000">> %RADir%\retroarch.cfg
echo menu_wallpaper_opacity = "0.300000">> %RADir%\retroarch.cfg
echo menu_framebuffer_opacity = "0.900000">> %RADir%\retroarch.cfg
echo menu_footer_opacity = "1.000000">> %RADir%\retroarch.cfg
echo menu_header_opacity = "1.000000">> %RADir%\retroarch.cfg
echo video_message_pos_x = "0.050000">> %RADir%\retroarch.cfg
echo video_message_pos_y = "0.050000">> %RADir%\retroarch.cfg
echo video_font_size = "32.000000">> %RADir%\retroarch.cfg
echo fastforward_ratio = "0.000000">> %RADir%\retroarch.cfg
echo slowmotion_ratio = "3.000000">> %RADir%\retroarch.cfg
echo input_axis_threshold = "0.500000">> %RADir%\retroarch.cfg
echo state_slot = "0">> %RADir%\retroarch.cfg
echo netplay_check_frames = "30">> %RADir%\retroarch.cfg
echo audio_wasapi_sh_buffer_length = "-16">> %RADir%\retroarch.cfg
echo input_bind_timeout = "5">> %RADir%\retroarch.cfg
echo input_turbo_period = "6">> %RADir%\retroarch.cfg
echo input_duty_cycle = "3">> %RADir%\retroarch.cfg
echo input_max_users = "5">> %RADir%\retroarch.cfg
echo input_menu_toggle_gamepad_combo = "4">> %RADir%\retroarch.cfg
echo audio_latency = "64">> %RADir%\retroarch.cfg
echo audio_block_frames = "0">> %RADir%\retroarch.cfg
echo rewind_granularity = "1">> %RADir%\retroarch.cfg
echo autosave_interval = "0">> %RADir%\retroarch.cfg
echo libretro_log_level = "1">> %RADir%\retroarch.cfg
echo keyboard_gamepad_mapping_type = "1">> %RADir%\retroarch.cfg
echo input_poll_type_behavior = "2">> %RADir%\retroarch.cfg
echo video_monitor_index = "0">> %RADir%\retroarch.cfg
echo video_fullscreen_x = "0">> %RADir%\retroarch.cfg
echo video_fullscreen_y = "0">> %RADir%\retroarch.cfg
echo video_window_x = "0">> %RADir%\retroarch.cfg
echo video_window_y = "0">> %RADir%\retroarch.cfg
echo network_cmd_port = "55355">> %RADir%\retroarch.cfg
echo network_remote_base_port = "55400">> %RADir%\retroarch.cfg
echo dpi_override_value = "200">> %RADir%\retroarch.cfg
echo menu_thumbnails = "3">> %RADir%\retroarch.cfg
echo xmb_alpha_factor = "75">> %RADir%\retroarch.cfg
echo xmb_scale_factor = "100">> %RADir%\retroarch.cfg
echo xmb_theme = "0">> %RADir%\retroarch.cfg
echo xmb_menu_color_theme = "4">> %RADir%\retroarch.cfg
echo materialui_menu_color_theme = "0">> %RADir%\retroarch.cfg
echo menu_shader_pipeline = "2">> %RADir%\retroarch.cfg
echo audio_out_rate = "48000">> %RADir%\retroarch.cfg
echo custom_viewport_width = "960">> %RADir%\retroarch.cfg
echo custom_viewport_height = "720">> %RADir%\retroarch.cfg
echo custom_viewport_x = "0">> %RADir%\retroarch.cfg
echo custom_viewport_y = "0">> %RADir%\retroarch.cfg
echo content_history_size = "100">> %RADir%\retroarch.cfg
echo video_hard_sync_frames = "0">> %RADir%\retroarch.cfg
echo video_frame_delay = "0">> %RADir%\retroarch.cfg
echo video_max_swapchain_images = "3">> %RADir%\retroarch.cfg
echo video_swap_interval = "1">> %RADir%\retroarch.cfg
echo video_rotation = "0">> %RADir%\retroarch.cfg
echo aspect_ratio_index = "21">> %RADir%\retroarch.cfg
echo netplay_ip_port = "55435">> %RADir%\retroarch.cfg
echo netplay_input_latency_frames_min = "0">> %RADir%\retroarch.cfg
echo netplay_input_latency_frames_range = "0">> %RADir%\retroarch.cfg
echo user_language = "0">> %RADir%\retroarch.cfg
echo bundle_assets_extract_version_current = "0">> %RADir%\retroarch.cfg
echo bundle_assets_extract_last_version = "0">> %RADir%\retroarch.cfg
echo input_overlay_show_physical_inputs_port = "0">> %RADir%\retroarch.cfg
echo input_device_p1 = "0">> %RADir%\retroarch.cfg
echo input_player1_joypad_index = "0">> %RADir%\retroarch.cfg
echo input_libretro_device_p1 = "1">> %RADir%\retroarch.cfg
echo input_player1_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player1_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p2 = "0">> %RADir%\retroarch.cfg
echo input_player2_joypad_index = "1">> %RADir%\retroarch.cfg
echo input_libretro_device_p2 = "1">> %RADir%\retroarch.cfg
echo input_player2_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player2_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p3 = "0">> %RADir%\retroarch.cfg
echo input_player3_joypad_index = "2">> %RADir%\retroarch.cfg
echo input_libretro_device_p3 = "1">> %RADir%\retroarch.cfg
echo input_player3_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player3_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p4 = "0">> %RADir%\retroarch.cfg
echo input_player4_joypad_index = "3">> %RADir%\retroarch.cfg
echo input_libretro_device_p4 = "1">> %RADir%\retroarch.cfg
echo input_player4_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player4_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p5 = "0">> %RADir%\retroarch.cfg
echo input_player5_joypad_index = "4">> %RADir%\retroarch.cfg
echo input_libretro_device_p5 = "1">> %RADir%\retroarch.cfg
echo input_player5_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player5_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p6 = "0">> %RADir%\retroarch.cfg
echo input_player6_joypad_index = "5">> %RADir%\retroarch.cfg
echo input_libretro_device_p6 = "1">> %RADir%\retroarch.cfg
echo input_player6_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player6_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p7 = "0">> %RADir%\retroarch.cfg
echo input_player7_joypad_index = "6">> %RADir%\retroarch.cfg
echo input_libretro_device_p7 = "1">> %RADir%\retroarch.cfg
echo input_player7_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player7_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p8 = "0">> %RADir%\retroarch.cfg
echo input_player8_joypad_index = "7">> %RADir%\retroarch.cfg
echo input_libretro_device_p8 = "1">> %RADir%\retroarch.cfg
echo input_player8_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player8_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p9 = "0">> %RADir%\retroarch.cfg
echo input_player9_joypad_index = "8">> %RADir%\retroarch.cfg
echo input_libretro_device_p9 = "1">> %RADir%\retroarch.cfg
echo input_player9_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player9_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p10 = "0">> %RADir%\retroarch.cfg
echo input_player10_joypad_index = "9">> %RADir%\retroarch.cfg
echo input_libretro_device_p10 = "1">> %RADir%\retroarch.cfg
echo input_player10_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player10_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p11 = "0">> %RADir%\retroarch.cfg
echo input_player11_joypad_index = "10">> %RADir%\retroarch.cfg
echo input_libretro_device_p11 = "1">> %RADir%\retroarch.cfg
echo input_player11_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player11_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p12 = "0">> %RADir%\retroarch.cfg
echo input_player12_joypad_index = "11">> %RADir%\retroarch.cfg
echo input_libretro_device_p12 = "1">> %RADir%\retroarch.cfg
echo input_player12_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player12_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p13 = "0">> %RADir%\retroarch.cfg
echo input_player13_joypad_index = "12">> %RADir%\retroarch.cfg
echo input_libretro_device_p13 = "1">> %RADir%\retroarch.cfg
echo input_player13_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player13_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p14 = "0">> %RADir%\retroarch.cfg
echo input_player14_joypad_index = "13">> %RADir%\retroarch.cfg
echo input_libretro_device_p14 = "1">> %RADir%\retroarch.cfg
echo input_player14_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player14_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p15 = "0">> %RADir%\retroarch.cfg
echo input_player15_joypad_index = "14">> %RADir%\retroarch.cfg
echo input_libretro_device_p15 = "1">> %RADir%\retroarch.cfg
echo input_player15_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player15_mouse_index = "0">> %RADir%\retroarch.cfg
echo input_device_p16 = "0">> %RADir%\retroarch.cfg
echo input_player16_joypad_index = "15">> %RADir%\retroarch.cfg
echo input_libretro_device_p16 = "1">> %RADir%\retroarch.cfg
echo input_player16_analog_dpad_mode = "0">> %RADir%\retroarch.cfg
echo input_player16_mouse_index = "0">> %RADir%\retroarch.cfg
echo ui_companion_start_on_boot = "true">> %RADir%\retroarch.cfg
echo ui_companion_enable = "false">> %RADir%\retroarch.cfg
echo video_gpu_record = "false">> %RADir%\retroarch.cfg
echo input_remap_binds_enable = "true">> %RADir%\retroarch.cfg
echo all_users_control_menu = "false">> %RADir%\retroarch.cfg
echo menu_swap_ok_cancel_buttons = "true">> %RADir%\retroarch.cfg
echo netplay_public_announce = "true">> %RADir%\retroarch.cfg
echo netplay_start_as_spectator = "false">> %RADir%\retroarch.cfg
echo netplay_allow_slaves = "true">> %RADir%\retroarch.cfg
echo netplay_require_slaves = "false">> %RADir%\retroarch.cfg
echo netplay_stateless_mode = "false">> %RADir%\retroarch.cfg
echo netplay_client_swap_input = "true">> %RADir%\retroarch.cfg
echo netplay_use_mitm_server = "false">> %RADir%\retroarch.cfg
echo input_descriptor_label_show = "true">> %RADir%\retroarch.cfg
echo input_descriptor_hide_unbound = "false">> %RADir%\retroarch.cfg
echo load_dummy_on_core_shutdown = "true">> %RADir%\retroarch.cfg
echo check_firmware_before_loading = "false">> %RADir%\retroarch.cfg
echo builtin_mediaplayer_enable = "true">> %RADir%\retroarch.cfg
echo builtin_imageviewer_enable = "true">> %RADir%\retroarch.cfg
echo fps_show = "false">> %RADir%\retroarch.cfg
echo ui_menubar_enable = "true">> %RADir%\retroarch.cfg
echo suspend_screensaver_enable = "true">> %RADir%\retroarch.cfg
echo rewind_enable = "false">> %RADir%\retroarch.cfg
echo audio_sync = "true">> %RADir%\retroarch.cfg
echo video_shader_enable = "false">> %RADir%\retroarch.cfg
echo video_aspect_ratio_auto = "false">> %RADir%\retroarch.cfg
echo video_allow_rotate = "true">> %RADir%\retroarch.cfg
echo video_windowed_fullscreen = "true">> %RADir%\retroarch.cfg
echo video_crop_overscan = "true">> %RADir%\retroarch.cfg
echo video_scale_integer = "false">> %RADir%\retroarch.cfg
echo video_smooth = "true">> %RADir%\retroarch.cfg
echo video_force_aspect = "true">> %RADir%\retroarch.cfg
echo video_threaded = "false">> %RADir%\retroarch.cfg
echo video_shared_context = "false">> %RADir%\retroarch.cfg
echo auto_screenshot_filename = "true">> %RADir%\retroarch.cfg
echo video_force_srgb_disable = "false">> %RADir%\retroarch.cfg
echo video_fullscreen = "true">> %RADir%\retroarch.cfg
echo bundle_assets_extract_enable = "false">> %RADir%\retroarch.cfg
echo video_vsync = "true">> %RADir%\retroarch.cfg
echo video_hard_sync = "false">> %RADir%\retroarch.cfg
echo video_black_frame_insertion = "false">> %RADir%\retroarch.cfg
echo video_disable_composition = "false">> %RADir%\retroarch.cfg
echo pause_nonactive = "true">> %RADir%\retroarch.cfg
echo video_gpu_screenshot = "true">> %RADir%\retroarch.cfg
echo video_post_filter_record = "false">> %RADir%\retroarch.cfg
echo keyboard_gamepad_enable = "true">> %RADir%\retroarch.cfg
echo core_set_supports_no_game_enable = "true">> %RADir%\retroarch.cfg
echo audio_enable = "true">> %RADir%\retroarch.cfg
echo audio_mute_enable = "false">> %RADir%\retroarch.cfg
echo audio_mixer_mute_enable = "false">> %RADir%\retroarch.cfg
echo location_allow = "false">> %RADir%\retroarch.cfg
echo video_font_enable = "true">> %RADir%\retroarch.cfg
echo core_updater_auto_extract_archive = "true">> %RADir%\retroarch.cfg
echo camera_allow = "false">> %RADir%\retroarch.cfg
echo menu_unified_controls = "false">> %RADir%\retroarch.cfg
echo threaded_data_runloop_enable = "true">> %RADir%\retroarch.cfg
echo menu_throttle_framerate = "true">> %RADir%\retroarch.cfg
echo menu_linear_filter = "true">> %RADir%\retroarch.cfg
echo menu_horizontal_animation = "true">> %RADir%\retroarch.cfg
echo dpi_override_enable = "true">> %RADir%\retroarch.cfg
echo menu_pause_libretro = "true">> %RADir%\retroarch.cfg
echo menu_mouse_enable = "true">> %RADir%\retroarch.cfg
echo menu_pointer_enable = "false">> %RADir%\retroarch.cfg
echo menu_timedate_enable = "true">> %RADir%\retroarch.cfg
echo menu_battery_level_enable = "true">> %RADir%\retroarch.cfg
echo menu_core_enable = "true">> %RADir%\retroarch.cfg
echo menu_dynamic_wallpaper_enable = "false">> %RADir%\retroarch.cfg
echo materialui_icons_enable = "true">> %RADir%\retroarch.cfg
echo xmb_shadows_enable = "true">> %RADir%\retroarch.cfg
echo xmb_show_settings = "true">> %RADir%\retroarch.cfg
echo xmb_show_favorites = "true">> %RADir%\retroarch.cfg
echo xmb_show_images = "true">> %RADir%\retroarch.cfg
echo xmb_show_music = "true">> %RADir%\retroarch.cfg
echo menu_show_online_updater = "true">> %RADir%\retroarch.cfg
echo menu_show_core_updater = "true">> %RADir%\retroarch.cfg
echo xmb_show_video = "true">> %RADir%\retroarch.cfg
echo xmb_show_netplay = "true">> %RADir%\retroarch.cfg
echo xmb_show_history = "true">> %RADir%\retroarch.cfg
echo xmb_show_add = "true">> %RADir%\retroarch.cfg
echo filter_by_current_core = "false">> %RADir%\retroarch.cfg
echo rgui_show_start_screen = "false">> %RADir%\retroarch.cfg
echo menu_navigation_wraparound_enable = "true">> %RADir%\retroarch.cfg
echo menu_navigation_browser_filter_supported_extensions_enable = "true">> %RADir%\retroarch.cfg
echo menu_show_advanced_settings = "true">> %RADir%\retroarch.cfg
echo cheevos_enable = "false">> %RADir%\retroarch.cfg
echo cheevos_test_unofficial = "false">> %RADir%\retroarch.cfg
echo cheevos_hardcore_mode_enable = "false">> %RADir%\retroarch.cfg
echo cheevos_verbose_enable = "false">> %RADir%\retroarch.cfg
echo input_overlay_enable = "true">> %RADir%\retroarch.cfg
echo input_overlay_enable_autopreferred = "true">> %RADir%\retroarch.cfg
echo input_overlay_show_physical_inputs = "false">> %RADir%\retroarch.cfg
echo input_overlay_hide_in_menu = "true">> %RADir%\retroarch.cfg
echo network_cmd_enable = "false">> %RADir%\retroarch.cfg
echo stdin_cmd_enable = "false">> %RADir%\retroarch.cfg
echo network_remote_enable = "false">> %RADir%\retroarch.cfg
echo netplay_nat_traversal = "true">> %RADir%\retroarch.cfg
echo block_sram_overwrite = "false">> %RADir%\retroarch.cfg
echo savestate_auto_index = "false">> %RADir%\retroarch.cfg
echo savestate_auto_save = "false">> %RADir%\retroarch.cfg
echo savestate_auto_load = "false">> %RADir%\retroarch.cfg
echo savestate_thumbnail_enable = "false">> %RADir%\retroarch.cfg
echo history_list_enable = "true">> %RADir%\retroarch.cfg
echo playlist_entry_remove = "true">> %RADir%\retroarch.cfg
echo game_specific_options = "true">> %RADir%\retroarch.cfg
echo auto_overrides_enable = "true">> %RADir%\retroarch.cfg
echo auto_remaps_enable = "true">> %RADir%\retroarch.cfg
echo auto_shaders_enable = "true">> %RADir%\retroarch.cfg
echo sort_savefiles_enable = "false">> %RADir%\retroarch.cfg
echo sort_savestates_enable = "false">> %RADir%\retroarch.cfg
echo show_hidden_files = "false">> %RADir%\retroarch.cfg
echo input_autodetect_enable = "true">> %RADir%\retroarch.cfg
echo audio_rate_control = "true">> %RADir%\retroarch.cfg
echo audio_wasapi_exclusive_mode = "true">> %RADir%\retroarch.cfg
echo audio_wasapi_float_format = "false">> %RADir%\retroarch.cfg
echo savestates_in_content_dir = "false">> %RADir%\retroarch.cfg
echo savefiles_in_content_dir = "false">> %RADir%\retroarch.cfg
echo systemfiles_in_content_dir = "false">> %RADir%\retroarch.cfg
echo screenshots_in_content_dir = "false">> %RADir%\retroarch.cfg
echo custom_bgm_enable = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p1 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p2 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p3 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p4 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p5 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p6 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p7 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p8 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p9 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p10 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p11 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p12 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p13 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p14 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p15 = "false">> %RADir%\retroarch.cfg
echo network_remote_enable_user_p16 = "false">> %RADir%\retroarch.cfg
echo log_verbosity = "false">> %RADir%\retroarch.cfg
echo perfcnt_enable = "false">> %RADir%\retroarch.cfg
echo video_message_color = "ffffff">> %RADir%\retroarch.cfg
echo menu_entry_normal_color = "ffffffff">> %RADir%\retroarch.cfg
echo menu_entry_hover_color = "ff64ff64">> %RADir%\retroarch.cfg
echo menu_title_color = "ff64ff64">> %RADir%\retroarch.cfg
echo gamma_correction = "false">> %RADir%\retroarch.cfg
echo flicker_filter_enable = "false">> %RADir%\retroarch.cfg
echo soft_filter_enable = "false">> %RADir%\retroarch.cfg
echo soft_filter_index = "0">> %RADir%\retroarch.cfg
echo current_resolution_id = "0">> %RADir%\retroarch.cfg
echo flicker_filter_index = "0">> %RADir%\retroarch.cfg
echo input_player1_b = "z">> %RADir%\retroarch.cfg
echo input_player1_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_y = "a">> %RADir%\retroarch.cfg
echo input_player1_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_select = "rshift">> %RADir%\retroarch.cfg
echo input_player1_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_start = "enter">> %RADir%\retroarch.cfg
echo input_player1_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_up = "up">> %RADir%\retroarch.cfg
echo input_player1_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_down = "down">> %RADir%\retroarch.cfg
echo input_player1_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_left = "left">> %RADir%\retroarch.cfg
echo input_player1_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_right = "right">> %RADir%\retroarch.cfg
echo input_player1_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_a = "x">> %RADir%\retroarch.cfg
echo input_player1_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_x = "s">> %RADir%\retroarch.cfg
echo input_player1_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_l = "q">> %RADir%\retroarch.cfg
echo input_player1_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_r = "w">> %RADir%\retroarch.cfg
echo input_player1_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player1_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player1_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player1_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player1_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player1_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player1_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player1_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_toggle_fast_forward = "space">> %RADir%\retroarch.cfg
echo input_toggle_fast_forward_btn = "nul">> %RADir%\retroarch.cfg
echo input_toggle_fast_forward_axis = "nul">> %RADir%\retroarch.cfg
echo input_hold_fast_forward = "l">> %RADir%\retroarch.cfg
echo input_hold_fast_forward_btn = "nul">> %RADir%\retroarch.cfg
echo input_hold_fast_forward_axis = "nul">> %RADir%\retroarch.cfg
echo input_load_state = "f4">> %RADir%\retroarch.cfg
echo input_load_state_btn = "nul">> %RADir%\retroarch.cfg
echo input_load_state_axis = "nul">> %RADir%\retroarch.cfg
echo input_save_state = "f2">> %RADir%\retroarch.cfg
echo input_save_state_btn = "nul">> %RADir%\retroarch.cfg
echo input_save_state_axis = "nul">> %RADir%\retroarch.cfg
echo input_toggle_fullscreen = "f">> %RADir%\retroarch.cfg
echo input_toggle_fullscreen_btn = "nul">> %RADir%\retroarch.cfg
echo input_toggle_fullscreen_axis = "nul">> %RADir%\retroarch.cfg
echo input_exit_emulator = "escape">> %RADir%\retroarch.cfg
echo input_exit_emulator_btn = "nul">> %RADir%\retroarch.cfg
echo input_exit_emulator_axis = "nul">> %RADir%\retroarch.cfg
echo input_state_slot_increase = "f7">> %RADir%\retroarch.cfg
echo input_state_slot_increase_btn = "nul">> %RADir%\retroarch.cfg
echo input_state_slot_increase_axis = "nul">> %RADir%\retroarch.cfg
echo input_state_slot_decrease = "f6">> %RADir%\retroarch.cfg
echo input_state_slot_decrease_btn = "nul">> %RADir%\retroarch.cfg
echo input_state_slot_decrease_axis = "nul">> %RADir%\retroarch.cfg
echo input_rewind = "r">> %RADir%\retroarch.cfg
echo input_rewind_btn = "nul">> %RADir%\retroarch.cfg
echo input_rewind_axis = "nul">> %RADir%\retroarch.cfg
echo input_movie_record_toggle = "o">> %RADir%\retroarch.cfg
echo input_movie_record_toggle_btn = "nul">> %RADir%\retroarch.cfg
echo input_movie_record_toggle_axis = "nul">> %RADir%\retroarch.cfg
echo input_pause_toggle = "p">> %RADir%\retroarch.cfg
echo input_pause_toggle_btn = "nul">> %RADir%\retroarch.cfg
echo input_pause_toggle_axis = "nul">> %RADir%\retroarch.cfg
echo input_frame_advance = "k">> %RADir%\retroarch.cfg
echo input_frame_advance_btn = "nul">> %RADir%\retroarch.cfg
echo input_frame_advance_axis = "nul">> %RADir%\retroarch.cfg
echo input_reset = "h">> %RADir%\retroarch.cfg
echo input_reset_btn = "nul">> %RADir%\retroarch.cfg
echo input_reset_axis = "nul">> %RADir%\retroarch.cfg
echo input_shader_next = "m">> %RADir%\retroarch.cfg
echo input_shader_next_btn = "nul">> %RADir%\retroarch.cfg
echo input_shader_next_axis = "nul">> %RADir%\retroarch.cfg
echo input_shader_prev = "n">> %RADir%\retroarch.cfg
echo input_shader_prev_btn = "nul">> %RADir%\retroarch.cfg
echo input_shader_prev_axis = "nul">> %RADir%\retroarch.cfg
echo input_cheat_index_plus = "y">> %RADir%\retroarch.cfg
echo input_cheat_index_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_cheat_index_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_cheat_index_minus = "t">> %RADir%\retroarch.cfg
echo input_cheat_index_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_cheat_index_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_cheat_toggle = "u">> %RADir%\retroarch.cfg
echo input_cheat_toggle_btn = "nul">> %RADir%\retroarch.cfg
echo input_cheat_toggle_axis = "nul">> %RADir%\retroarch.cfg
echo input_screenshot = "f8">> %RADir%\retroarch.cfg
echo input_screenshot_btn = "nul">> %RADir%\retroarch.cfg
echo input_screenshot_axis = "nul">> %RADir%\retroarch.cfg
echo input_audio_mute = "f9">> %RADir%\retroarch.cfg
echo input_audio_mute_btn = "nul">> %RADir%\retroarch.cfg
echo input_audio_mute_axis = "nul">> %RADir%\retroarch.cfg
echo input_osk_toggle = "f12">> %RADir%\retroarch.cfg
echo input_osk_toggle_btn = "nul">> %RADir%\retroarch.cfg
echo input_osk_toggle_axis = "nul">> %RADir%\retroarch.cfg
echo input_netplay_flip_players_1_2 = "nul">> %RADir%\retroarch.cfg
echo input_netplay_flip_players_1_2_btn = "nul">> %RADir%\retroarch.cfg
echo input_netplay_flip_players_1_2_axis = "nul">> %RADir%\retroarch.cfg
echo input_netplay_game_watch = "i">> %RADir%\retroarch.cfg
echo input_netplay_game_watch_btn = "nul">> %RADir%\retroarch.cfg
echo input_netplay_game_watch_axis = "nul">> %RADir%\retroarch.cfg
echo input_slowmotion = "e">> %RADir%\retroarch.cfg
echo input_slowmotion_btn = "nul">> %RADir%\retroarch.cfg
echo input_slowmotion_axis = "nul">> %RADir%\retroarch.cfg
echo input_enable_hotkey = "nul">> %RADir%\retroarch.cfg
echo input_enable_hotkey_btn = "nul">> %RADir%\retroarch.cfg
echo input_enable_hotkey_axis = "nul">> %RADir%\retroarch.cfg
echo input_volume_up = "add">> %RADir%\retroarch.cfg
echo input_volume_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_volume_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_volume_down = "subtract">> %RADir%\retroarch.cfg
echo input_volume_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_volume_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_overlay_next = "nul">> %RADir%\retroarch.cfg
echo input_overlay_next_btn = "nul">> %RADir%\retroarch.cfg
echo input_overlay_next_axis = "nul">> %RADir%\retroarch.cfg
echo input_disk_eject_toggle = "nul">> %RADir%\retroarch.cfg
echo input_disk_eject_toggle_btn = "nul">> %RADir%\retroarch.cfg
echo input_disk_eject_toggle_axis = "nul">> %RADir%\retroarch.cfg
echo input_disk_next = "nul">> %RADir%\retroarch.cfg
echo input_disk_next_btn = "nul">> %RADir%\retroarch.cfg
echo input_disk_next_axis = "nul">> %RADir%\retroarch.cfg
echo input_disk_prev = "nul">> %RADir%\retroarch.cfg
echo input_disk_prev_btn = "nul">> %RADir%\retroarch.cfg
echo input_disk_prev_axis = "nul">> %RADir%\retroarch.cfg
echo input_grab_mouse_toggle = "f11">> %RADir%\retroarch.cfg
echo input_grab_mouse_toggle_btn = "nul">> %RADir%\retroarch.cfg
echo input_grab_mouse_toggle_axis = "nul">> %RADir%\retroarch.cfg
echo input_game_focus_toggle = "scroll_lock">> %RADir%\retroarch.cfg
echo input_game_focus_toggle_btn = "nul">> %RADir%\retroarch.cfg
echo input_game_focus_toggle_axis = "nul">> %RADir%\retroarch.cfg
echo input_menu_toggle = "f1">> %RADir%\retroarch.cfg
echo input_menu_toggle_btn = "nul">> %RADir%\retroarch.cfg
echo input_menu_toggle_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_b = "nul">> %RADir%\retroarch.cfg
echo input_player2_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_y = "nul">> %RADir%\retroarch.cfg
echo input_player2_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_select = "nul">> %RADir%\retroarch.cfg
echo input_player2_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_start = "nul">> %RADir%\retroarch.cfg
echo input_player2_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_up = "nul">> %RADir%\retroarch.cfg
echo input_player2_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_down = "nul">> %RADir%\retroarch.cfg
echo input_player2_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_left = "nul">> %RADir%\retroarch.cfg
echo input_player2_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_right = "nul">> %RADir%\retroarch.cfg
echo input_player2_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_a = "nul">> %RADir%\retroarch.cfg
echo input_player2_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_x = "nul">> %RADir%\retroarch.cfg
echo input_player2_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_l = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_r = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player2_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player2_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player2_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player2_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player2_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player2_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player2_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_b = "nul">> %RADir%\retroarch.cfg
echo input_player3_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_y = "nul">> %RADir%\retroarch.cfg
echo input_player3_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_select = "nul">> %RADir%\retroarch.cfg
echo input_player3_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_start = "nul">> %RADir%\retroarch.cfg
echo input_player3_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_up = "nul">> %RADir%\retroarch.cfg
echo input_player3_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_down = "nul">> %RADir%\retroarch.cfg
echo input_player3_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_left = "nul">> %RADir%\retroarch.cfg
echo input_player3_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_right = "nul">> %RADir%\retroarch.cfg
echo input_player3_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_a = "nul">> %RADir%\retroarch.cfg
echo input_player3_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_x = "nul">> %RADir%\retroarch.cfg
echo input_player3_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_l = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_r = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player3_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player3_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player3_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player3_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player3_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player3_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player3_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_b = "nul">> %RADir%\retroarch.cfg
echo input_player4_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_y = "nul">> %RADir%\retroarch.cfg
echo input_player4_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_select = "nul">> %RADir%\retroarch.cfg
echo input_player4_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_start = "nul">> %RADir%\retroarch.cfg
echo input_player4_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_up = "nul">> %RADir%\retroarch.cfg
echo input_player4_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_down = "nul">> %RADir%\retroarch.cfg
echo input_player4_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_left = "nul">> %RADir%\retroarch.cfg
echo input_player4_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_right = "nul">> %RADir%\retroarch.cfg
echo input_player4_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_a = "nul">> %RADir%\retroarch.cfg
echo input_player4_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_x = "nul">> %RADir%\retroarch.cfg
echo input_player4_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_l = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_r = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player4_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player4_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player4_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player4_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player4_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player4_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player4_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_b = "nul">> %RADir%\retroarch.cfg
echo input_player5_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_y = "nul">> %RADir%\retroarch.cfg
echo input_player5_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_select = "nul">> %RADir%\retroarch.cfg
echo input_player5_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_start = "nul">> %RADir%\retroarch.cfg
echo input_player5_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_up = "nul">> %RADir%\retroarch.cfg
echo input_player5_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_down = "nul">> %RADir%\retroarch.cfg
echo input_player5_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_left = "nul">> %RADir%\retroarch.cfg
echo input_player5_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_right = "nul">> %RADir%\retroarch.cfg
echo input_player5_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_a = "nul">> %RADir%\retroarch.cfg
echo input_player5_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_x = "nul">> %RADir%\retroarch.cfg
echo input_player5_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_l = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_r = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player5_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player5_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player5_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player5_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player5_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player5_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player5_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_b = "nul">> %RADir%\retroarch.cfg
echo input_player6_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_y = "nul">> %RADir%\retroarch.cfg
echo input_player6_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_select = "nul">> %RADir%\retroarch.cfg
echo input_player6_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_start = "nul">> %RADir%\retroarch.cfg
echo input_player6_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_up = "nul">> %RADir%\retroarch.cfg
echo input_player6_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_down = "nul">> %RADir%\retroarch.cfg
echo input_player6_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_left = "nul">> %RADir%\retroarch.cfg
echo input_player6_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_right = "nul">> %RADir%\retroarch.cfg
echo input_player6_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_a = "nul">> %RADir%\retroarch.cfg
echo input_player6_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_x = "nul">> %RADir%\retroarch.cfg
echo input_player6_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_l = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_r = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player6_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player6_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player6_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player6_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player6_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player6_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player6_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_b = "nul">> %RADir%\retroarch.cfg
echo input_player7_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_y = "nul">> %RADir%\retroarch.cfg
echo input_player7_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_select = "nul">> %RADir%\retroarch.cfg
echo input_player7_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_start = "nul">> %RADir%\retroarch.cfg
echo input_player7_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_up = "nul">> %RADir%\retroarch.cfg
echo input_player7_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_down = "nul">> %RADir%\retroarch.cfg
echo input_player7_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_left = "nul">> %RADir%\retroarch.cfg
echo input_player7_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_right = "nul">> %RADir%\retroarch.cfg
echo input_player7_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_a = "nul">> %RADir%\retroarch.cfg
echo input_player7_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_x = "nul">> %RADir%\retroarch.cfg
echo input_player7_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_l = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_r = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player7_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player7_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player7_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player7_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player7_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player7_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player7_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_b = "nul">> %RADir%\retroarch.cfg
echo input_player8_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_y = "nul">> %RADir%\retroarch.cfg
echo input_player8_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_select = "nul">> %RADir%\retroarch.cfg
echo input_player8_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_start = "nul">> %RADir%\retroarch.cfg
echo input_player8_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_up = "nul">> %RADir%\retroarch.cfg
echo input_player8_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_down = "nul">> %RADir%\retroarch.cfg
echo input_player8_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_left = "nul">> %RADir%\retroarch.cfg
echo input_player8_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_right = "nul">> %RADir%\retroarch.cfg
echo input_player8_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_a = "nul">> %RADir%\retroarch.cfg
echo input_player8_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_x = "nul">> %RADir%\retroarch.cfg
echo input_player8_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_l = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_r = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player8_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player8_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player8_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player8_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player8_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player8_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player8_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_b = "nul">> %RADir%\retroarch.cfg
echo input_player9_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_y = "nul">> %RADir%\retroarch.cfg
echo input_player9_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_select = "nul">> %RADir%\retroarch.cfg
echo input_player9_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_start = "nul">> %RADir%\retroarch.cfg
echo input_player9_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_up = "nul">> %RADir%\retroarch.cfg
echo input_player9_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_down = "nul">> %RADir%\retroarch.cfg
echo input_player9_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_left = "nul">> %RADir%\retroarch.cfg
echo input_player9_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_right = "nul">> %RADir%\retroarch.cfg
echo input_player9_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_a = "nul">> %RADir%\retroarch.cfg
echo input_player9_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_x = "nul">> %RADir%\retroarch.cfg
echo input_player9_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_l = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_r = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player9_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player9_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player9_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player9_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player9_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player9_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player9_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_b = "nul">> %RADir%\retroarch.cfg
echo input_player10_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_y = "nul">> %RADir%\retroarch.cfg
echo input_player10_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_select = "nul">> %RADir%\retroarch.cfg
echo input_player10_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_start = "nul">> %RADir%\retroarch.cfg
echo input_player10_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_up = "nul">> %RADir%\retroarch.cfg
echo input_player10_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_down = "nul">> %RADir%\retroarch.cfg
echo input_player10_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_left = "nul">> %RADir%\retroarch.cfg
echo input_player10_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_right = "nul">> %RADir%\retroarch.cfg
echo input_player10_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_a = "nul">> %RADir%\retroarch.cfg
echo input_player10_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_x = "nul">> %RADir%\retroarch.cfg
echo input_player10_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_l = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_r = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player10_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player10_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player10_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player10_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player10_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player10_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player10_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_b = "nul">> %RADir%\retroarch.cfg
echo input_player11_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_y = "nul">> %RADir%\retroarch.cfg
echo input_player11_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_select = "nul">> %RADir%\retroarch.cfg
echo input_player11_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_start = "nul">> %RADir%\retroarch.cfg
echo input_player11_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_up = "nul">> %RADir%\retroarch.cfg
echo input_player11_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_down = "nul">> %RADir%\retroarch.cfg
echo input_player11_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_left = "nul">> %RADir%\retroarch.cfg
echo input_player11_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_right = "nul">> %RADir%\retroarch.cfg
echo input_player11_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_a = "nul">> %RADir%\retroarch.cfg
echo input_player11_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_x = "nul">> %RADir%\retroarch.cfg
echo input_player11_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_l = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_r = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player11_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player11_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player11_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player11_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player11_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player11_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player11_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_b = "nul">> %RADir%\retroarch.cfg
echo input_player12_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_y = "nul">> %RADir%\retroarch.cfg
echo input_player12_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_select = "nul">> %RADir%\retroarch.cfg
echo input_player12_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_start = "nul">> %RADir%\retroarch.cfg
echo input_player12_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_up = "nul">> %RADir%\retroarch.cfg
echo input_player12_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_down = "nul">> %RADir%\retroarch.cfg
echo input_player12_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_left = "nul">> %RADir%\retroarch.cfg
echo input_player12_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_right = "nul">> %RADir%\retroarch.cfg
echo input_player12_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_a = "nul">> %RADir%\retroarch.cfg
echo input_player12_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_x = "nul">> %RADir%\retroarch.cfg
echo input_player12_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_l = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_r = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player12_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player12_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player12_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player12_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player12_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player12_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player12_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_b = "nul">> %RADir%\retroarch.cfg
echo input_player13_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_y = "nul">> %RADir%\retroarch.cfg
echo input_player13_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_select = "nul">> %RADir%\retroarch.cfg
echo input_player13_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_start = "nul">> %RADir%\retroarch.cfg
echo input_player13_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_up = "nul">> %RADir%\retroarch.cfg
echo input_player13_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_down = "nul">> %RADir%\retroarch.cfg
echo input_player13_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_left = "nul">> %RADir%\retroarch.cfg
echo input_player13_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_right = "nul">> %RADir%\retroarch.cfg
echo input_player13_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_a = "nul">> %RADir%\retroarch.cfg
echo input_player13_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_x = "nul">> %RADir%\retroarch.cfg
echo input_player13_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_l = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_r = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player13_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player13_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player13_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player13_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player13_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player13_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player13_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_b = "nul">> %RADir%\retroarch.cfg
echo input_player14_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_y = "nul">> %RADir%\retroarch.cfg
echo input_player14_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_select = "nul">> %RADir%\retroarch.cfg
echo input_player14_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_start = "nul">> %RADir%\retroarch.cfg
echo input_player14_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_up = "nul">> %RADir%\retroarch.cfg
echo input_player14_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_down = "nul">> %RADir%\retroarch.cfg
echo input_player14_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_left = "nul">> %RADir%\retroarch.cfg
echo input_player14_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_right = "nul">> %RADir%\retroarch.cfg
echo input_player14_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_a = "nul">> %RADir%\retroarch.cfg
echo input_player14_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_x = "nul">> %RADir%\retroarch.cfg
echo input_player14_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_l = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_r = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player14_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player14_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player14_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player14_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player14_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player14_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player14_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_b = "nul">> %RADir%\retroarch.cfg
echo input_player15_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_y = "nul">> %RADir%\retroarch.cfg
echo input_player15_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_select = "nul">> %RADir%\retroarch.cfg
echo input_player15_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_start = "nul">> %RADir%\retroarch.cfg
echo input_player15_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_up = "nul">> %RADir%\retroarch.cfg
echo input_player15_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_down = "nul">> %RADir%\retroarch.cfg
echo input_player15_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_left = "nul">> %RADir%\retroarch.cfg
echo input_player15_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_right = "nul">> %RADir%\retroarch.cfg
echo input_player15_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_a = "nul">> %RADir%\retroarch.cfg
echo input_player15_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_x = "nul">> %RADir%\retroarch.cfg
echo input_player15_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_l = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_r = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player15_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player15_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player15_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player15_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player15_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player15_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player15_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_b = "nul">> %RADir%\retroarch.cfg
echo input_player16_b_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_b_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_y = "nul">> %RADir%\retroarch.cfg
echo input_player16_y_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_y_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_select = "nul">> %RADir%\retroarch.cfg
echo input_player16_select_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_select_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_start = "nul">> %RADir%\retroarch.cfg
echo input_player16_start_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_start_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_up = "nul">> %RADir%\retroarch.cfg
echo input_player16_up_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_up_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_down = "nul">> %RADir%\retroarch.cfg
echo input_player16_down_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_down_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_left = "nul">> %RADir%\retroarch.cfg
echo input_player16_left_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_left_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_right = "nul">> %RADir%\retroarch.cfg
echo input_player16_right_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_right_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_a = "nul">> %RADir%\retroarch.cfg
echo input_player16_a_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_a_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_x = "nul">> %RADir%\retroarch.cfg
echo input_player16_x_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_x_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_l = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_r = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_l2 = "nul">> %RADir%\retroarch.cfg
echo input_player16_l2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_l2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_r2 = "nul">> %RADir%\retroarch.cfg
echo input_player16_r2_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_r2_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_l3 = "nul">> %RADir%\retroarch.cfg
echo input_player16_l3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_l3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_r3 = "nul">> %RADir%\retroarch.cfg
echo input_player16_r3_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_r3_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_l_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_x_plus = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_x_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_x_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_x_minus = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_x_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_x_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_y_plus = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_y_plus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_y_plus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_y_minus = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_y_minus_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_r_y_minus_axis = "nul">> %RADir%\retroarch.cfg
echo input_player16_turbo = "nul">> %RADir%\retroarch.cfg
echo input_player16_turbo_btn = "nul">> %RADir%\retroarch.cfg
echo input_player16_turbo_axis = "nul">> %RADir%\retroarch.cfg
echo video_msg_bgcolor_opacity = "1.000000">> %RADir%\retroarch.cfg
echo keymapper_port = "0">> %RADir%\retroarch.cfg
echo video_msg_bgcolor_red = "0">> %RADir%\retroarch.cfg
echo video_msg_bgcolor_green = "0">> %RADir%\retroarch.cfg
echo video_msg_bgcolor_blue = "0">> %RADir%\retroarch.cfg
echo framecount_show = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_take_screenshot = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_save_load_state = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_undo_save_load_state = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_add_to_favorites = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_options = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_controls = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_cheats = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_shaders = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_save_core_overrides = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_save_game_overrides = "true">> %RADir%\retroarch.cfg
echo quick_menu_show_information = "true">> %RADir%\retroarch.cfg
echo kiosk_mode_enable = "false">> %RADir%\retroarch.cfg
echo menu_show_load_core = "true">> %RADir%\retroarch.cfg
echo menu_show_load_content = "true">> %RADir%\retroarch.cfg
echo menu_show_information = "true">> %RADir%\retroarch.cfg
echo menu_show_configurations = "true">> %RADir%\retroarch.cfg
echo menu_show_help = "true">> %RADir%\retroarch.cfg
echo menu_show_quit_retroarch = "true">> %RADir%\retroarch.cfg
echo menu_show_reboot = "true">> %RADir%\retroarch.cfg
echo keymapper_enable = "true">> %RADir%\retroarch.cfg
echo playlist_entry_rename = "true">> %RADir%\retroarch.cfg
echo video_msg_bgcolor_enable = "false">> %RADir%\retroarch.cfg
echo cheevos_leaderboards_enable = "false">> %RADir%\retroarch.cfg
echo xmb_font = "">> %RADir%\retroarch.cfg
echo xmb_show_settings_password = "">> %RADir%\retroarch.cfg
echo kiosk_mode_password = "">> %RADir%\retroarch.cfg
echo netplay_nickname = "">> %RADir%\retroarch.cfg
echo video_filter = "">> %RADir%\retroarch.cfg
echo audio_dsp_plugin = "">> %RADir%\retroarch.cfg
echo netplay_ip_address = "">> %RADir%\retroarch.cfg
echo netplay_password = "">> %RADir%\retroarch.cfg
echo netplay_spectate_password = "">> %RADir%\retroarch.cfg
echo core_options_path = "">> %RADir%\retroarch.cfg
echo video_shader = "">> %RADir%\retroarch.cfg
echo menu_wallpaper = "">> %RADir%\retroarch.cfg
echo input_overlay = "">> %RADir%\retroarch.cfg
echo video_font_path = "">> %RADir%\retroarch.cfg
echo content_history_dir = "">> %RADir%\retroarch.cfg
echo cache_directory = "">> %RADir%\retroarch.cfg
echo resampler_directory = "">> %RADir%\retroarch.cfg
echo recording_output_directory = "">> %RADir%\retroarch.cfg
echo recording_config_directory = "">> %RADir%\retroarch.cfg
echo xmb_font = "">> %RADir%\retroarch.cfg
echo playlist_names = "">> %RADir%\retroarch.cfg
echo playlist_cores = "">> %RADir%\retroarch.cfg
echo audio_device = "">> %RADir%\retroarch.cfg
echo camera_device = "">> %RADir%\retroarch.cfg
echo video_context_driver = "">> %RADir%\retroarch.cfg
echo input_keyboard_layout = "">> %RADir%\retroarch.cfg
echo bundle_assets_src_path = "">> %RADir%\retroarch.cfg
echo bundle_assets_dst_path = "">> %RADir%\retroarch.cfg
echo bundle_assets_dst_path_subdir = "">> %RADir%\retroarch.cfg
goto updatecores
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:updatecores
::Checks architecture for installing/updating retroarch cores
cls
mkdir "%tempDir%\cores"
cls
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto x64core
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto x86core
	)

:x64core
::Installed all RetroArch cores needed by RP4Win. 64 bit
cls
echo =================================================================
echo =                                                               =
echo =     Downloading RetroArch cores. This will take some time     =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/2048_libretro.dll.zip -O "%tempDir%\cores\1.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/4do_libretro.dll.zip -O "%tempDir%\cores\3.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/atari800_libretro.dll.zip -O "%tempDir%\cores\5.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/bluemsx_libretro.dll.zip -O "%tempDir%\cores\6.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/bnes_libretro.dll.zip -O "%tempDir%\cores\7.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/cap32_libretro.dll.zip -O "%tempDir%\cores\15.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/fbalpha_libretro.dll.zip -O "%tempDir%\cores\31.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/fceumm_libretro.dll.zip -O "%tempDir%\cores\32.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/fuse_libretro.dll.zip -O "%tempDir%\cores\35.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/gambatte_libretro.dll.zip -O "%tempDir%\cores\36.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/genesis_plus_gx_libretro.dll.zip -O "%tempDir%\cores\37.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/gpsp_libretro.dll.zip -O "%tempDir%\cores\39.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/handy_libretro.dll.zip -O "%tempDir%\cores\41.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mame2003_libretro.dll.zip -O "%tempDir%\cores\47.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mame2010_libretro.dll.zip -O "%tempDir%\cores\48.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mame2014_libretro.dll.zip -O "%tempDir%\cores\49.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mame_libretro.dll.zip -O "%tempDir%\cores\50.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_gba_libretro.dll.zip -O "%tempDir%\cores\51.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_ngp_libretro.dll.zip -O "%tempDir%\cores\53.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_pce_fast_libretro.dll.zip -O "%tempDir%\cores\54.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_psx_hw_libretro.dll.zip -O "%tempDir%\cores\56.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_psx_libretro.dll.zip -O "%tempDir%\cores\57.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_saturn_libretro.dll.zip -O "%tempDir%\cores\58.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mednafen_supergrafx_libretro.dll.zip -O "%tempDir%\cores\60.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/melonds_libretro.dll.zip -O "%tempDir%\cores\63.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/mupen64plus_libretro.dll.zip -O "%tempDir%\cores\68.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/nestopia_libretro.dll.zip -O "%tempDir%\cores\70.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/pcsx_rearmed_libretro.dll.zip -O "%tempDir%\cores\76.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/picodrive_libretro.dll.zip -O "%tempDir%\cores\77.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/ppsspp_libretro.dll.zip -O "%tempDir%\cores\80.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/prosystem_libretro.dll.zip -O "%tempDir%\cores\82.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/puae_libretro.dll.zip -O "%tempDir%\cores\83.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/px68k_libretro.dll.zip -O "%tempDir%\cores\84.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/redream_libretro.dll.zip -O "%tempDir%\cores\86.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/reicast_libretro.dll.zip -O "%tempDir%\cores\87.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/snes9x2010_libretro.dll.zip -O "%tempDir%\cores\94.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/stella_libretro.dll.zip -O "%tempDir%\cores\96.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/vecx_libretro.dll.zip -O "%tempDir%\cores\102.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86_64/latest/virtualjaguar_libretro.dll.zip -O "%tempDir%\cores\106.zip"
mkdir %RADir%\cores
%toolsDir%\7za\7za.exe x "%tempDir%\cores\*.zip" -o"%RADir%\cores" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 4 >nul
rmdir "%tempDir%\cores" /s /q
IF EXIST %tempDir%\BrandNewBlank goto InstallAllEmu
IF EXIST %tempDir%\BrandNewDef goto InstallAllEmu
IF EXIST %tempDir%\BrandNewCus goto InstallAllEmu
goto completed

:x86core
::Installed all RetroArch cores needed by RP4Win. 32 bit
cls
echo =================================================================
echo =                                                               =
echo =     Downloading RetroArch cores. This will take some time     =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/2048_libretro.dll.zip -O "%tempDir%\cores\1.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/4do_libretro.dll.zip -O "%tempDir%\cores\3.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/atari800_libretro.dll.zip -O "%tempDir%\cores\5.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/bluemsx_libretro.dll.zip -O "%tempDir%\cores\6.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/bnes_libretro.dll.zip -O "%tempDir%\cores\7.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/cap32_libretro.dll.zip -O "%tempDir%\cores\15.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/fbalpha_libretro.dll.zip -O "%tempDir%\cores\31.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/fceumm_libretro.dll.zip -O "%tempDir%\cores\32.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/fuse_libretro.dll.zip -O "%tempDir%\cores\35.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/genesis_plus_gx_libretro.dll.zip -O "%tempDir%\cores\37.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/gpsp_libretro.dll.zip -O "%tempDir%\cores\39.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/handy_libretro.dll.zip -O "%tempDir%\cores\41.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mame2003_libretro.dll.zip -O "%tempDir%\cores\47.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mame2010_libretro.dll.zip -O "%tempDir%\cores\48.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mame2014_libretro.dll.zip -O "%tempDir%\cores\49.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mame_libretro.dll.zip -O "%tempDir%\cores\50.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mednafen_gba_libretro.dll.zip -O "%tempDir%\cores\51.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mednafen_ngp_libretro.dll.zip -O "%tempDir%\cores\53.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mednafen_pce_fast_libretro.dll.zip -O "%tempDir%\cores\54.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mednafen_psx_hw_libretro.dll.zip -O "%tempDir%\cores\56.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mednafen_psx_libretro.dll.zip -O "%tempDir%\cores\57.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mednafen_saturn_libretro.dll.zip -O "%tempDir%\cores\58.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mednafen_supergrafx_libretro.dll.zip -O "%tempDir%\cores\60.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/melonds_libretro.dll.zip -O "%tempDir%\cores\63.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/mupen64plus_libretro.dll.zip -O "%tempDir%\cores\68.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/nestopia_libretro.dll.zip -O "%tempDir%\cores\70.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/pcsx_rearmed_libretro.dll.zip -O "%tempDir%\cores\76.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/picodrive_libretro.dll.zip -O "%tempDir%\cores\77.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/ppsspp_libretro.dll.zip -O "%tempDir%\cores\80.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/prosystem_libretro.dll.zip -O "%tempDir%\cores\82.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/puae_libretro.dll.zip -O "%tempDir%\cores\83.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/px68k_libretro.dll.zip -O "%tempDir%\cores\84.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/redream_libretro.dll.zip -O "%tempDir%\cores\86.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/reicast_libretro.dll.zip -O "%tempDir%\cores\87.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/snes9x2010_libretro.dll.zip -O "%tempDir%\cores\94.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/stella_libretro.dll.zip -O "%tempDir%\cores\96.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/vecx_libretro.dll.zip -O "%tempDir%\cores\102.zip"
%toolsDir%\Wget\wget.exe -q http://buildbot.libretro.com/nightly/windows/x86/latest/virtualjaguar_libretro.dll.zip -O "%tempDir%\cores\106.zip"
mkdir %RADir%\cores
%toolsDir%\7za\7za.exe x "%tempDir%\cores\*.zip" -o"%RADir%\cores" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 4 >nul
rmdir "%tempDir%\cores" /s /q
IF EXIST %tempDir%\BrandNewBlank goto InstallAllEmu
IF EXIST %tempDir%\BrandNewDef goto InstallAllEmu
IF EXIST %tempDir%\BrandNewCus goto InstallAllEmu
goto completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection7
::Menu for cleaning stuff. Mostly just for me when debugging stuff and I need to uninstall and reinstall multiple times.
cls
echo ===========================================
echo              System Cleanup             
echo ===========================================
echo **1.) REMOVE ALL RP4Win FILES
echo -------------------------------------------
echo **2.) REMOVE EMULATIONSTATION AND PREFERENCES
echo -------------------------------------------
echo **3.) REMOVE RETROARCH AND PREFERENCES
echo -------------------------------------------
echo **4.) REMOVE ADDITIONAL EMULATORS AND PREFERENCES
echo -------------------------------------------
echo **5.) REMOVE RP4Win TOOLS (GIT AND 7ZA)
echo -------------------------------------------
echo **6.) EXIT
echo ===========================================
CHOICE /C 123456 /N /T 60 /D 6 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==6 GOTO Main
IF ERRORLEVEL ==5 GOTO CleanTools
IF ERRORLEVEL ==4 GOTO CleanEmu
IF ERRORLEVEL ==3 GOTO CleanRA
IF ERRORLEVEL ==2 GOTO CleanES
IF ERRORLEVEL ==1 GOTO CleanAll
::==============================================
:CleanAll
::Prompts confirmation before wiping out all files.
cls
set /P c=Are you sure you want to delete ALL RP4Win Files (Tries to move roms from %romsDir% to %USERPROFILE%\ROMS, but backup roms just to be safe before proceeding-)[Y/N]?
if /I "%c%" EQU "Y" goto delall
if /I "%c%" EQU "N" goto Main
::==============================================
:delall
::Deletes any and all files used or created by RP4Win. Moves any ROMS found in the RP4Win directory to %USERPROFILE%\ROMS as to not wipe out your collection. does not remove ROMS in custom directories.
cls
echo =====================================================
echo =                                                   =
echo = DELETING ALL RETROARCH AND EMULATIONSTATION FILES =
echo =                                                   =
echo =====================================================
cd /D C:\
IF EXIST "%romsDir%\" move "%romsDir%" "%USERPROFILE%\ROMS"
del "%USERPROFILE%\Desktop\RP4Win.lnk"
del "%APPDATA%\RP4Win\CusInstallDir.txt"
rmdir "%rp4winDir%" /s /q
rmdir "%USERPROFILE%\.emulationstation" /s /q
goto CleanAllExit
::==============================================
:CleanES
::Prompts for the deletion of all EmulationStation and related files
cls
set /P c=Are you sure you want to delete ALL EmulationStation Files (Includes Settings)[Y/N]?
if /I "%c%" EQU "Y" goto delES
if /I "%c%" EQU "N" goto menu
::==============================================
:delES
::Deletes all emulationstation files.
cls
echo =====================================================
echo =                                                   =
echo =          DELETING EMULATIONSTATION FILES          =
echo =                                                   =
echo =====================================================
del "%USERPROFILE%\Desktop\RP4Win.lnk"
rmdir %esDir% /s /q
rmdir "%USERPROFILE%\.emulationstation" /s /q
goto CleanAllExit
::==============================================
:CleanRA
::Prompts for the deletion of all RetroArch and related files
cls
set /P c=Are you sure you want to delete ALL RetroArch Files (Includes Settings)[Y/N]?
if /I "%c%" EQU "Y" goto delRA
if /I "%c%" EQU "N" goto menu
::==============================================
:delRA
::Deletes all RetroArch and related files
cls
echo =====================================================
echo =                                                   =
echo =             DELETING RETROARCH FILES              =
echo =                                                   =
echo =====================================================
rmdir %RADir% /s /q
goto CleanAllExit
::==============================================
:CleanEmu
::Prompts for the deletion of all additional emulators and related files
cls
set /P c=Are you sure you want to delete ALL Additional Emulators (Includes Settings)[Y/N]?
if /I "%c%" EQU "Y" goto delEmu
if /I "%c%" EQU "N" goto menu
::==============================================
:delEmu
::Deletes all additional emulators.
cls
echo =====================================================
echo =                                                   =
echo =        DELETING ADDITIONAL EMULATORS FILES        =
echo =                                                   =
echo =====================================================
rmdir %systemsDir% /s /q
goto CleanAllExit
::==============================================
:CleanTools
::Prompts for the deletion of RP4Win's support tools (7za, git, etc)
cls
set /P c=Are you sure you want to delete ALL RP4Win tools (Includes Settings)[Y/N]?
if /I "%c%" EQU "Y" goto delTools
if /I "%c%" EQU "N" goto menu
::==============================================
:delTools
::Deletes all tools used by RP4Win (Relaunching the batch file will redownload and install them.
cls
echo =====================================================
echo =                                                   =
echo =             DELETING RP4Win TOOLS              =
echo =                                                   =
echo =====================================================
rmdir %toolsDir% /s /q
goto CleanAllExit
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:ThemeManager
::Menu for managing and installing themes for EmulationStation
cls
echo ===========================================
echo                Theme Manager                 
echo ===========================================
echo **1.) INSTALL/UPDATE ALL EMULATIONSTATION THEMES
echo -------------------------------------------
echo **2.) INSTALL/UPDATE INDIVIDUAL THEMES
echo -------------------------------------------
echo **3.) THEME GALLERY/PREVIEWS
echo -------------------------------------------
echo **4.) EXIT THEME MANAGER
echo ===========================================
CHOICE /C 1234 /N /T 30 /D 4 /M "Enter Menu Item Number (1, 2, 3, 4): "
IF ERRORLEVEL ==4 GOTO Selection2
IF ERRORLEVEL ==3 GOTO ThemeGallerySetupCheck
IF ERRORLEVEL ==2 GOTO IndThemes
IF ERRORLEVEL ==1 GOTO AllThemes
::==============================================
:ThemeGallerySetupCheck
::Checks if the Theme Gallery is already setup. if not goes to the setup.
IF EXIST "%USERPROFILE%\.emulationstation\es-theme-gallery\carbon.png" goto ThemeGallery
goto ThemeGallerySetup
::==============================================
:ThemeGallerySetup
::Clones the "theme gallery" into the emulationstation settings folder
cd /D "%USERPROFILE%\.emulationstation"
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/wetriner/es-theme-gallery.git
goto ThemeGallery
::==============================================
:ThemeGallery
::Creates a basic HTML file with the images in the theme gallery. Prompts the user on how to interact. Once closed deletes the html file.
cd /D "%USERPROFILE%\.emulationstation\es-theme-gallery"
for %%i in (*.png) do echo ^<img src="%%i" title="%%~ni" height="400" width="600" /^> >> Gallery.html
start Gallery.html
cls
echo ===========================================================================
echo =                                                                         =
echo =       HOVER OVER ANY IMAGE TO SEE WHICH THEME IT BELONGS TO             =
echo =            PRESS ANY KEY WHEN DONE BROWSING THE GALLERY                 =
echo =                                                                         =
echo ===========================================================================
pause > nul
del Gallery.html
goto ThemeManager
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:AllThemes
::Using git clones all available themes into the theme folder for emulationstation.
cd /D "%themesDir%"
set repo=RetroPie
set theme=carbon
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroPie
set theme=carbon-centered
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroPie
set theme=carbon-nometa
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroPie
set theme=simple
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroPie
set theme=simple-dark
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroPie
set theme=clean-look
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroPie
set theme=color-pi
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroPie
set theme=nbba
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroPie
set theme=simplified-static-canela
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroPie
set theme=turtle-pi
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroPie
set theme=zoid
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=ehettervik
set theme=pixel
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=ehettervik
set theme=pixel-metadata
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=ehettervik
set theme=pixel-tft
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=ehettervik
set theme=luminous
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=ehettervik
set theme=minilumi
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=ehettervik
set theme=workbench
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=AmadhiX
set theme=eudora
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=AmadhiX
set theme=eudora-bigshot
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=AmadhiX
set theme=eudora-concise
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
::set repo=ChoccyHobNob
::set theme=eudora-updated
::rmdir %theme% /S /Q
::%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=InsecureSpike
set theme=retroplay-clean-canela
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=InsecureSpike
set theme=retroplay-clean-detail-canela
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=Omnija
set theme=simpler-turtlepi
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=Omnija
set theme=simpler-turtlemini
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=Omnija
set theme=metro
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=lilbud
set theme=material
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=mattrixk
set theme=io
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=mattrixk
set theme=metapixel
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=mattrixk
set theme=spare
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=robertybob
set theme=space
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=robertybob
set theme=simplebigart
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=robertybob
set theme=tv
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=HerbFargus
set theme=tronkyfran
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=lilbud
set theme=flat
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=lilbud
set theme=flat-dark
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=lilbud
set theme=minimal
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=lilbud
set theme=switch-light
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=lilbud
set theme=switch-dark
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=FlyingTomahawk
set theme=futura-V
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=FlyingTomahawk
set theme=futura-dark-V
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=G-rila
set theme=fundamental
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=ruckage
set theme=nes-mini
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=ruckage
set theme=famicom-mini
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=ruckage
set theme=snes-mini
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=anthonycaccese
set theme=crt
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=anthonycaccese
set theme=crt-centered
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=anthonycaccese
set theme=art-book
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=anthonycaccese
set theme=art-book-4-3
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=anthonycaccese
set theme=art-book-pocket
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=anthonycaccese
set theme=tft
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=TMNTturtleguy
set theme=ComicBook
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=TMNTturtleguy
set theme=ComicBook_4-3
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=TMNTturtleguy
set theme=ComicBook_SE-Wheelart
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=TMNTturtleguy
set theme=ComicBook_4-3_SE-Wheelart
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=ChoccyHobNob
set theme=cygnus
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=dmmarti
set theme=steampunk
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=dmmarti
set theme=hurstyblue
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=dmmarti
set theme=maximuspie
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=dmmarti
set theme=showcase
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=dmmarti
set theme=kidz
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=lipebello
set theme=Retrorama
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=lipebello
set theme=SpaceOddity
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=rxbrad
set theme=gbz35
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=rxbrad
set theme=gbz35-dark
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=garaine
set theme=marioblue
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=garaine
set theme=bigwood
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=MrTomixf
set theme=Royal_Primicia
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroHursty69
set theme=magazinemadness
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroHursty69
set theme=stirling
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=lostless
set theme=playstation
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=mrharias
set theme=superdisplay
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=coinjunkie
set theme=synthwave
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroHursty69
set theme=boxalloyred
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroHursty69
set theme=boxalloyblue
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroHursty69
set theme=greenilicious
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroHursty69
set theme=retroroid
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=RetroHursty69
set theme=merryxmas
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
set repo=Saracade
set theme=scv720
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
goto ThemeManager
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:IndThemes
::Menus for installing individual themes for EmulationStation.
:page1
cls
echo ===========================================
echo      Install/Update Individual Themes                 
echo ===========================================
echo *               Page 1                    *
echo *    1.) CARBON                           *
echo *    2.) CARBON-CENTERED                  *
echo *    3.) CARBON-NOMETA                    *
echo *    4.) SIMPLE                           *
echo *    5.) SIMPLE-DARK                      *
echo *    6.) CLEAN-LOOK                       *
echo *    7.) COLOR-PI                         *
echo *    8.) NBBA                             *
echo *                                         *
echo *    9.) Page 2                           *
echo *                                         *
echo ===========================================
CHOICE /C 123456789Q /N /T 30 /D Q /M "Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO ThemeManager
IF ERRORLEVEL ==9 GOTO page2
IF ERRORLEVEL ==8 goto nbba 
IF ERRORLEVEL ==7 goto color-pi 
IF ERRORLEVEL ==6 goto clean-look 
IF ERRORLEVEL ==5 goto simple-dark 
IF ERRORLEVEL ==4 goto simple 
IF ERRORLEVEL ==3 goto carbon-nometa 
IF ERRORLEVEL ==2 goto carbon-centered 
IF ERRORLEVEL ==1 goto carbon 
::==============================================
:page2
cls
echo ===========================================
echo      Install/Update Individual Themes                 
echo ===========================================
echo *                Page 2                   *
echo *    1.) SIMPLIFIED-STATIC-CANELA         *
echo *    2.) TURTLE-PI                        *
echo *    3.) ZOID                             *
echo *    4.) PIXEL                            *
echo *    5.) PIXEL-METADATA                   *
echo *    6.) PIXEL-TFT                        *
echo *    7.) LUMINOUS                         *
echo *    8.) MINILUMI                         *
echo *                                         *
echo *    9.) Page 3                           *
echo *                                         *
echo ===========================================
CHOICE /C 123456789Q /N /T 30 /D Q /M "Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO ThemeManager
IF ERRORLEVEL ==9 GOTO page3
IF ERRORLEVEL ==8 goto minilumi
IF ERRORLEVEL ==7 goto luminous
IF ERRORLEVEL ==6 goto pixel-tft
IF ERRORLEVEL ==5 goto pixel-metadata
IF ERRORLEVEL ==4 goto pixel
IF ERRORLEVEL ==3 goto zoid
IF ERRORLEVEL ==2 goto turtle-pi 
IF ERRORLEVEL ==1 goto simplified-static-canela
::==============================================
:page3
cls
echo ===========================================
echo      Install/Update Individual Themes                 
echo ===========================================
echo *                Page 3                   *
echo *    1.) WORKBENCH                        *
echo *    2.) EUDORA                           *
echo *    3.) EUDORA-BIGSHOT                   *
echo *    4.) EUDORA-CONCISE                   *
echo *    5.) EUDORA-UPDATED (Unavailable)     *
echo *    6.) RETROPLAY-CLEAN-CANELA           *
echo *    7.) RETROPLAY-CLEAN-DETAIL-CANELA    *
echo *    8.) SIMPLER-TURTLEPI                 *
echo *                                         *
echo *    9.) Page 4                           *
echo *                                         *
echo ===========================================
CHOICE /C 123456789Q /N /T 30 /D Q /M "Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO ThemeManager
IF ERRORLEVEL ==9 GOTO page4
IF ERRORLEVEL ==8 goto simpler-turtlepi
IF ERRORLEVEL ==7 goto retroplay-clean-detail-canela
IF ERRORLEVEL ==6 goto retroplay-clean-canela
IF ERRORLEVEL ==5 goto page3
IF ERRORLEVEL ==4 goto eudora-concise
IF ERRORLEVEL ==3 goto eudora-bigshot
IF ERRORLEVEL ==2 goto eudora
IF ERRORLEVEL ==1 goto workbench
::==============================================
:page4
cls
echo ===========================================
echo      Install/Update Individual Themes                 
echo ===========================================
echo *                Page 4                   *
echo *    1.) SIMPLER-TURTLEMINI               *
echo *    2.) METRO                            *
echo *    3.) MATERIAL                         *
echo *    4.) IO                               *
echo *    5.) METAPIXEL                        *
echo *    6.) SPARE                            *
echo *    7.) SPACE                            *
echo *    8.) SIMPLEBIGART                     *
echo *                                         *
echo *    9.) Page 5                           *
echo *                                         *
echo ===========================================
CHOICE /C 123456789Q /N /T 30 /D Q /M "Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO ThemeManager
IF ERRORLEVEL ==9 GOTO page5
IF ERRORLEVEL ==8 goto simplebigart
IF ERRORLEVEL ==7 goto space
IF ERRORLEVEL ==6 goto spare
IF ERRORLEVEL ==5 goto metapixel
IF ERRORLEVEL ==4 goto io
IF ERRORLEVEL ==3 goto material
IF ERRORLEVEL ==2 goto metro
IF ERRORLEVEL ==1 goto simpler-turtlemini
::==============================================
:page5
cls
echo ===========================================
echo      Install/Update Individual Themes                 
echo ===========================================
echo *                Page 5                   *
echo *    1.) TV                               *
echo *    2.) TRONKYFRAN                       *
echo *    3.) FLAT                             *
echo *    4.) FLAT-DARK                        *
echo *    5.) MINIMAL                          *
echo *    6.) SWITCH-LIGHT                     *
echo *    7.) SWITCH-DARK                      *
echo *    8.) FUTURA-V                         *
echo *                                         *
echo *    9.) Page 6                           *
echo *                                         *
echo ===========================================
CHOICE /C 123456789Q /N /T 30 /D Q /M "Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO ThemeManager
IF ERRORLEVEL ==9 GOTO page6
IF ERRORLEVEL ==8 goto futura-V
IF ERRORLEVEL ==7 goto switch-dark
IF ERRORLEVEL ==6 goto switch-light
IF ERRORLEVEL ==5 goto minimal
IF ERRORLEVEL ==4 goto flat-dark
IF ERRORLEVEL ==3 goto flat
IF ERRORLEVEL ==2 goto tronkyfran
IF ERRORLEVEL ==1 goto tv
::==============================================
:page6
cls
echo ===========================================
echo      Install/Update Individual Themes                 
echo ===========================================
echo *                Page 6                   *
echo *    1.) FUTURA-DARK-V                    *
echo *    2.) FUNDAMENTAL                      *
echo *    3.) NES-MINI                         *
echo *    4.) FAMICOM-MINI                     *
echo *    5.) SNES-MINI                        *
echo *    6.) CRT                              *
echo *    7.) CRT-CENTERED                     *
echo *    8.) ART-BOOK                         *
echo *                                         *
echo *    9.) Page 7                           *
echo *                                         *
echo ===========================================
CHOICE /C 123456789Q /N /T 30 /D Q /M "Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO ThemeManager
IF ERRORLEVEL ==9 GOTO page7
IF ERRORLEVEL ==8 goto art-book
IF ERRORLEVEL ==7 goto crt-centered
IF ERRORLEVEL ==6 goto crt
IF ERRORLEVEL ==5 goto snesminiind
IF ERRORLEVEL ==4 goto famicom-mini
IF ERRORLEVEL ==3 goto nes-mini
IF ERRORLEVEL ==2 goto fundamental
IF ERRORLEVEL ==1 goto futura-dark-V
::==============================================
:page7
cls
echo ===========================================
echo      Install/Update Individual Themes                 
echo ===========================================
echo *                Page 7                   *
echo *    1.) ART-BOOK-4-3                     *
echo *    2.) ART-BOOK-POCKET                  *
echo *    3.) TFT                              *
echo *    4.) COMICBOOK                        *
echo *    5.) COMICBOOK_4-3                    *
echo *    6.) COMICBOOK_SE-WHEELART            *
echo *    7.) COMICBOOK_4-3_SE-WHEELART        *
echo *    8.) CYGNUS                           *
echo *                                         *
echo *    9.) Page 8                           *
echo *                                         *
echo ===========================================
CHOICE /C 123456789Q /N /T 30 /D Q /M "Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO ThemeManager
IF ERRORLEVEL ==9 GOTO page8
IF ERRORLEVEL ==8 goto cygnus
IF ERRORLEVEL ==7 goto ComicBook_4-3_SE-Wheelart
IF ERRORLEVEL ==6 goto ComicBook_SE-Wheelart
IF ERRORLEVEL ==5 goto ComicBook_4-3
IF ERRORLEVEL ==4 goto ComicBook
IF ERRORLEVEL ==3 goto tft
IF ERRORLEVEL ==2 goto art-book-pocket
IF ERRORLEVEL ==1 goto art-book-4-3
::==============================================
:page8
cls
echo ===========================================
echo      Install/Update Individual Themes                 
echo ===========================================
echo *                Page 8                   *
echo *    1.) STEAMPUNK                        *
echo *    2.) HURSTYBLUE                       *
echo *    3.) MAXIMUSPIE                       *
echo *    4.) SHOWCASE                         *
echo *    5.) KIDZ                             *
echo *    6.) RETRORAMA                        *
echo *    7.) SPACEODDITY                      *
echo *    8.) GBZ35                            *
echo *                                         *
echo *    9.) Page 9                           *
echo *                                         *
echo ===========================================
CHOICE /C 123456789Q /N /T 30 /D Q /M "Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO ThemeManager
IF ERRORLEVEL ==9 GOTO page9
IF ERRORLEVEL ==8 goto gbz35
IF ERRORLEVEL ==7 goto SpaceOddity
IF ERRORLEVEL ==6 goto Retrorama
IF ERRORLEVEL ==5 goto kidz
IF ERRORLEVEL ==4 goto showcase
IF ERRORLEVEL ==3 goto maximuspie
IF ERRORLEVEL ==2 goto hurstyblue
IF ERRORLEVEL ==1 goto steampunk
::==============================================
:page9
cls
echo ===========================================
echo      Install/Update Individual Themes                 
echo ===========================================
echo *                Page 9                   *
echo *    1.) GBZ35-DARK                       *
echo *    2.) MARIOBLUE                        *
echo *    3.) BIGWOOD                          *
echo *    4.) ROYAL_PRIMICIA                   *
echo *    5.) MAGAZINEMADNESS                  *
echo *    6.) STIRLING                         *
echo *    7.) PLAYSTATION                      *
echo *    8.) SUPERDISPLAY                     *
echo *                                         *
echo *    9.) Page 10                          *
echo *                                         *
echo ===========================================
CHOICE /C 123456789Q /N /T 30 /D Q /M "Enter Menu Item Number: "
IF ERRORLEVEL ==10 GOTO ThemeManager
IF ERRORLEVEL ==9 GOTO page10
IF ERRORLEVEL ==8 goto superdisplay
IF ERRORLEVEL ==7 goto playstation
IF ERRORLEVEL ==6 goto stirling
IF ERRORLEVEL ==5 goto magazinemadness
IF ERRORLEVEL ==4 goto Royal_Primicia
IF ERRORLEVEL ==3 goto bigwood
IF ERRORLEVEL ==2 goto marioblue
IF ERRORLEVEL ==1 goto gbz35-dark
::==============================================
:page10
cls
echo ===========================================
echo      Install/Update Individual Themes                 
echo ===========================================
echo *                Page 10                  *
echo *    1.) SCV720                           *
echo *    2.) MERRYXMAS                        *
echo *    3.) RETROROID                        *
echo *    4.) GREENILICIOUS                    *
echo *    5.) BOXALLOYBLUE                     *
echo *    6.) BOXALLOYRED                      *
echo *    7.) SYNTHWAVE                        *
echo *                                         *
echo *    8.) Return to ThemeManager           *
echo *                                         *
echo ===========================================
CHOICE /C 12345678 /N /T 30 /D 8 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==8 goto ThemeManager
IF ERRORLEVEL ==7 goto synthwave
IF ERRORLEVEL ==6 goto boxalloyred
IF ERRORLEVEL ==5 goto boxalloyblue
IF ERRORLEVEL ==4 goto greenilicious
IF ERRORLEVEL ==3 goto retroroid
IF ERRORLEVEL ==2 goto merryxmas
IF ERRORLEVEL ==1 goto scv720
::==============================================
::Sets a variable for each theme individually. Then moves to cloning from github.
:carbon
set repo=RetroPie
set theme=carbon
goto insttheme
:carbon-centered
set repo=RetroPie
set theme=carbon-centered
goto insttheme
:carbon-nometa
set repo=RetroPie
set theme=carbon-nometa
goto insttheme
:simple
set repo=RetroPie
set theme=simple
goto insttheme
:simple-dark
set repo=RetroPie
set theme=simple-dark
goto insttheme
:clean-look
set repo=RetroPie
set theme=clean-look
goto insttheme
:color-pi
set repo=RetroPie
set theme=color-pi
goto insttheme
:nbba
set repo=RetroPie
set theme=nbba
goto insttheme
:simplified-static-canela
set repo=RetroPie
set theme=simplified-static-canela
goto insttheme
:turtle-pi
set repo=RetroPie
set theme=turtle-pi
goto insttheme
:zoid
set repo=RetroPie
set theme=zoid
goto insttheme
:pixel
set repo=ehettervik
set theme=pixel
goto insttheme
:pixel-metadata
set repo=ehettervik
set theme=pixel-metadata
goto insttheme
:pixel-tft
set repo=ehettervik
set theme=pixel-tft
goto insttheme
:luminous
set repo=ehettervik
set theme=luminous
goto insttheme
:minilumi
set repo=ehettervik
set theme=minilumi
goto insttheme
:workbench
set repo=ehettervik
set theme=workbench
goto insttheme
:eudora
set repo=AmadhiX
set theme=eudora
goto insttheme
:eudora-bigshot
set repo=AmadhiX
set theme=eudora-bigshot
goto insttheme
:eudora-concise
set repo=AmadhiX
set theme=eudora-concise
goto insttheme
::eudora-updated
::set repo=ChoccyHobNob
::set theme=eudora-updated
::goto insttheme
:retroplay-clean-canela
set repo=InsecureSpike
set theme=retroplay-clean-canela
goto insttheme
:retroplay-clean-detail-canela
set repo=InsecureSpike
set theme=retroplay-clean-detail-canela
goto insttheme
:simpler-turtlepi
set repo=Omnija
set theme=simpler-turtlepi
goto insttheme
:simpler-turtlemini
set repo=Omnija
set theme=simpler-turtlemini
goto insttheme
:metro
set repo=Omnija
set theme=metro
goto insttheme
:material
set repo=lilbud
set theme=material
goto insttheme
:io
set repo=mattrixk
set theme=io
goto insttheme
:metapixel
set repo=mattrixk
set theme=metapixel
goto insttheme
:spare
set repo=mattrixk
set theme=spare
goto insttheme
:space
set repo=robertybob
set theme=space
goto insttheme
:simplebigart
set repo=robertybob
set theme=simplebigart
goto insttheme
:tv
set repo=robertybob
set theme=tv
goto insttheme
:tronkyfran
set repo=HerbFargus
set theme=tronkyfran
goto insttheme
:flat
set repo=lilbud
set theme=flat
goto insttheme
:flat-dark
set repo=lilbud
set theme=flat-dark
goto insttheme
:minimal
set repo=lilbud
set theme=minimal
goto insttheme
:switch-light
set repo=lilbud
set theme=switch-light
goto insttheme
:switch-dark
set repo=lilbud
set theme=switch-dark
goto insttheme
:futura-V
set repo=FlyingTomahawk
set theme=futura-V
goto insttheme
:futura-dark-V
set repo=FlyingTomahawk
set theme=futura-dark-V
goto insttheme
:fundamental
set repo=G-rila
set theme=fundamental
goto insttheme
:nes-mini
set repo=ruckage
set theme=nes-mini
goto insttheme
:famicom-mini
set repo=ruckage
set theme=famicom-mini
goto insttheme
:snesminiind
set repo=ruckage
set theme=snes-mini
goto insttheme
:crt
set repo=anthonycaccese
set theme=crt
goto insttheme
:crt-centered
set repo=anthonycaccese
set theme=crt-centered
goto insttheme
:art-book
set repo=anthonycaccese
set theme=art-book
goto insttheme
:art-book-4-3
set repo=anthonycaccese
set theme=art-book-4-3
goto insttheme
:art-book-pocket
set repo=anthonycaccese
set theme=art-book-pocket
goto insttheme
:tft
set repo=anthonycaccese
set theme=tft
goto insttheme
:ComicBook
set repo=TMNTturtleguy
set theme=ComicBook
goto insttheme
:ComicBook_4-3
set repo=TMNTturtleguy
set theme=ComicBook_4-3
goto insttheme
:ComicBook_SE-Wheelart
set repo=TMNTturtleguy
set theme=ComicBook_SE-Wheelart
goto insttheme
:ComicBook_4-3_SE-Wheelart
set repo=TMNTturtleguy
set theme=ComicBook_4-3_SE-Wheelart
goto insttheme
:cygnus
set repo=ChoccyHobNob
set theme=cygnus
goto insttheme
:steampunk
set repo=dmmarti
set theme=steampunk
goto insttheme
:hurstyblue
set repo=dmmarti
set theme=hurstyblue
goto insttheme
:maximuspie
set repo=dmmarti
set theme=maximuspie
goto insttheme
:showcase
set repo=dmmarti
set theme=showcase
goto insttheme
:kidz
set repo=dmmarti
set theme=kidz
goto insttheme
:Retrorama
set repo=lipebello
set theme=Retrorama
goto insttheme
:SpaceOddity
set repo=lipebello
set theme=SpaceOddity
goto insttheme
:gbz35
set repo=rxbrad
set theme=gbz35
goto insttheme
:gbz35-dark
set repo=rxbrad
set theme=gbz35-dark
goto insttheme
:marioblue
set repo=garaine
set theme=marioblue
goto insttheme
:bigwood
set repo=garaine
set theme=bigwood
goto insttheme
:Royal_Primicia
set repo=MrTomixf
set theme=Royal_Primicia
goto insttheme
:magazinemadness
set repo=RetroHursty69
set theme=magazinemadness
goto insttheme
:stirling
set repo=RetroHursty69
set theme=stirling
goto insttheme
:playstation
set repo=lostless
set theme=playstation
goto insttheme
:superdisplay
set repo=mrharias
set theme=superdisplay
goto insttheme
:synthwave
set repo=coinjunkie
set theme=synthwave
goto insttheme
:boxalloyred
set repo=RetroHursty69
set theme=boxalloyred
goto insttheme
:boxalloyblue
set repo=RetroHursty69
set theme=boxalloyblue
goto insttheme
:greenilicious
set repo=RetroHursty69
set theme=greenilicious
goto insttheme
:retroroid
set repo=RetroHursty69
set theme=retroroid
goto insttheme
:merryxmas
set repo=RetroHursty69
set theme=merryxmas
goto insttheme
:scv720
set repo=Saracade
set theme=scv720
goto insttheme
:insttheme
::Uses the variable set in the selection for git cloning.
cd /D %themesDir%
rmdir %theme% /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
goto ThemeManager
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:AppleWin
::Installs AppleWin (Apple II Emulator)
cls
echo =================================================================
echo =                                                               =
echo =                     DOWNLOADING APPLEWIN                      =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/AppleWin/AppleWin/releases/download/v1.26.3.4/AppleWin1.26.3.4.zip -O "%tempDir%\AppleWin.zip"
mkdir %systemsDir%\AppleWin
%toolsDir%\7za\7za.exe x "%tempDir%\AppleWin.zip" -o"%systemsDir%\AppleWin" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 3 > nul
del %tempDir%\AppleWin.zip
if EXIST %systemsDir%\tmp.txt goto Hatari
goto completed
::==============================================
:Hatari
::Installs Hatari emulator.
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto hatari64
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto hatari32
	)

:hatari32
cls
echo =================================================================
echo =                                                               =
echo =                      DOWNLOADING HATARI                       =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://download.tuxfamily.org/hatari/2.0.0/hatari-2.0.0_windows.zip -O "%tempDir%\Hatari32.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\Hatari32.zip" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
cd /D %systemsDir%
ren %systemsDir%\hatari-2.0.0_windows Hatari
ping 127.0.0.1 -n 2 > nul
del %tempDir%\Hatari32.zip
if EXIST %systemsDir%\tmp.txt goto BeebEm
goto completed

:hatari64
cls
echo =================================================================
echo =                                                               =
echo =                      DOWNLOADING HATARI                       =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://download.tuxfamily.org/hatari/2.0.0/hatari-2.0.0_windows64.zip -O "%tempDir%\Hatari64.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\Hatari64.zip" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
cd /D %systemsDir%
ren %systemsDir%\hatari-2.0.0_windows64 Hatari
ping 127.0.0.1 -n 2 > nul
del %tempDir%\Hatari64.zip
if EXIST %systemsDir%\tmp.txt goto BeebEm
goto completed
::==============================================
:BeebEm
::Installs the Beebem emulator (BBMicro Emulator)
cls
echo =================================================================
echo =                                                               =
echo =                       DOWNLOADING BEEBEM                      =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://www.mkw.me.uk/beebem/BeebEm414.zip -O "%tempDir%\BeebEm.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\BeebEm.zip" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
del %tempDir%\BeebEm.zip
if EXIST %systemsDir%\tmp.txt goto XRoar
goto completed
::==============================================
:XRoar
::Installs the Xroar emulator for Dragon and CoCo
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto xroar64
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto xroar32
	)

:xroar32
cls
echo =================================================================
echo =                                                               =
echo =                        DOWNLOADING XROAR                      =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://www.6809.org.uk/xroar/dl/xroar-0.34.8-w32.zip -O "%tempDir%\XRoar32.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\XRoar32.zip" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
cd /D %systemsDir%
ren %systemsDir%\xroar-0.34.8-w32 XRoar
ping 127.0.0.1 -n 2 > nul
del %tempDir%\XRoar32.zip
if EXIST %systemsDir%\tmp.txt goto Daphne
goto completed

:xroar64
cls
echo =================================================================
echo =                                                               =
echo =                        DOWNLOADING XROAR                      =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://www.6809.org.uk/xroar/dl/xroar-0.34.8-w64.zip -O "%tempDir%\XRoar64.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\XRoar64.zip" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
cd /D %systemsDir%
ren %systemsDir%\xroar-0.34.8-w64 XRoar
ping 127.0.0.1 -n 2 > nul
del %tempDir%\XRoar64.zip
if EXIST %systemsDir%\tmp.txt goto Daphne
goto completed
::==============================================
:Daphne
::Installs Daphne (Laserdisc emulator)
cls
echo =================================================================
echo =                                                               =
echo =                      DOWNLOADING DAPHNE                       =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://www.daphne-emu.com/download/daphne-1.0v-win32.zip -O "%tempDir%\Daphne.zip"
mkdir %systemsDir%\Daphne
%toolsDir%\7za\7za.exe x "%tempDir%\Daphne.zip" -o"%systemsDir%\Daphne" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
del %tempDir%\Daphne.zip
if EXIST %systemsDir%\tmp.txt goto jzIntv
goto completed
::==============================================
:jzIntv
::Installs jzIntv (Intellivision emulator)
cls
echo =================================================================
echo =                                                               =
echo =                       DOWNLOADING JZINTV                      =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://spatula-city.org/~im14u2c/intv/dl/jzintv-20181225-win32.zip -O "%tempDir%\jzintv.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\jzintv.zip" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
cd /D %systemsDir%
ren %systemsDir%\jzintv-20181225-win32 jzIntv
ping 127.0.0.1 -n 2 > nul
del %tempDir%\jzIntv.zip
if EXIST %systemsDir%\tmp.txt goto PCSX2
goto completed
::==============================================
:PCSX2
::Installs PCSX2 (PS2 Emulator)
cls
echo =================================================================
echo =                                                               =
echo =                       DOWNLOADING PCSX2                       =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://www.emulator-zone.com/download.php/emulators/ps2/pcsx2/pcsx2-1.4.0-binaries.7z -O "%tempDir%\PCSX2.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\PCSX2.zip" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
cd /D %systemsDir%
ren "%systemsDir%\PCSX2 1.4.0" pcsx2
ping 127.0.0.1 -n 2 > nul
del %tempDir%\PCSX2.zip
if EXIST %systemsDir%\tmp.txt goto DolphinEmu
goto completed
::==============================================
:DolphinEmu
::Installs Dolphin (Gamecube and Wii emulator)
cls
echo =================================================================
echo =                                                               =
echo =                     DOWNLOADING DOLPHIN                       =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://dl.dolphin-emu.org/builds/07/ef/dolphin-master-5.0-11991-x64.7z -O "%tempDir%\Dolphin.7z"
%toolsDir%\7za\7za.exe x "%tempDir%\Dolphin.7z" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
cd /D %systemsDir%
ren %systemsDir%\Dolphin-x64 Dolphin
ping 127.0.0.1 -n 2 > nul
del %tempDir%\Dolphin.7z
del %tempDir%\VC_Redist_2017.exe
if EXIST %systemsDir%\tmp.txt goto CemuEmu
goto completed
::==============================================
:CemuEmu
::Installs Cemu (WiiU emulator)
cls
echo =================================================================
echo =                                                               =
echo =                      DOWNLOADING CEMU                         =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://cemu.info/releases/cemu_1.18.2.zip -O "%tempDir%\cemu.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\cemu.zip" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
cd /D %systemsDir%
ren %systemsDir%\cemu_1.18.2 cemu
ping 127.0.0.1 -n 2 > nul
del %tempDir%\cemu.zip
if EXIST %systemsDir%\tmp.txt goto VICE
goto completed
::==============================================
:VICE
::Installs the VICE emulator (Commodore 64 emulator)
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto VICE64
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto VICE32
	)

:VICE32
cls
echo =================================================================
echo =                                                               =
echo =                       DOWNLOADING VICE                        =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://newcontinuum.dl.sourceforge.net/project/vice-emu/releases/binaries/windows/GTK3VICE-3.3-win32.7z -O "%tempDir%\VICE32.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\VICE32.zip" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
cd /D %systemsDir%
ren %systemsDir%\GTK3VICE-3.3-win32-r35872 WinVICE
ping 127.0.0.1 -n 2 > nul
del %tempDir%\VICE32.zip
if EXIST %systemsDir%\tmp.txt goto tmpClean
goto completed

:VICE64
cls
echo =================================================================
echo =                                                               =
echo =                       DOWNLOADING VICE                        =
echo =                                                               =
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://managedway.dl.sourceforge.net/project/vice-emu/releases/binaries/windows/GTK3VICE-3.4-win64.7z -O "%tempDir%\VICE64.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\VICE64.zip" -o"%systemsDir%" -aoa > nul
cls
echo ================================================
echo =        Cleaning up downloaded file(s)        =
echo ================================================
ping 127.0.0.1 -n 2 > nul
cd /D %systemsDir%
ren %systemsDir%\GTK3VICE-3.4-win64-r37296 WinVICE
ping 127.0.0.1 -n 2 > nul
del %tempDir%\VICE64.zip
if EXIST %systemsDir%\tmp.txt goto tmpClean
goto completed
::==============================================
:tmpClean
::Cleans up temp files created by the automated installers.
del %systemsDir%\tmp.txt /s /q
IF EXIST %tempDir%\BrandNewBlank goto DediAsk
IF EXIST %tempDir%\BrandNewDef goto DediAsk
IF EXIST %tempDir%\BrandNewCus goto DediAsk
goto completed
::=================================================================================================================================================================================================================================================================================================================
::==============================================
::Rom Scraper
::==============================================
:Selection8
IF EXIST %toolsDir%\scraper.exe goto ScraperMenu

:ScraperArch
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		goto ScraperDL64
	)
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
		goto ScraperDL86
	)
	
:ScraperDL86
%toolsDir%\Wget\wget.exe -q https://github.com/sselph/scraper/releases/download/v1.4.6/scraper_windows_386.zip -O "%tempDir%\scraperx86.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\scraperx86.zip" -o"%toolsDir%" -aoa > nul
goto ScraperMenu

:ScraperDL64
%toolsDir%\Wget\wget.exe -q https://github.com/sselph/scraper/releases/download/v1.4.6/scraper_windows_amd64.zip -O "%tempDir%\scraperx64.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\scraperx64.zip" -o"%toolsDir%" -aoa > nul
goto ScraperMenu

:ScraperMenu
::Currently Disabled as SSelph's scraper no longer works.
goto Disabled
cls
echo ===========================================
echo               Rom Scraper             
echo ===========================================
echo **1.) SCRAPE ALL ROMS
echo -------------------------------------------
echo **2.) SCRAPE INDIVIDUAL SYSTEMS
echo -------------------------------------------
echo **3.) RETURN TO MAIN MENU
echo ===========================================
CHOICE /C 123 /N /T 30 /D 3 /M "Enter Menu Item Number: "
IF ERRORLEVEL ==3 GOTO Main
IF ERRORLEVEL ==2 GOTO ScraperSysMenu
IF ERRORLEVEL ==1 GOTO ScrapeAll
:ScrapeAll
%toolsDir%\scraper.exe -scrape_all
goto completed
:ScraperSysMenu
cls
echo ===========================================================================
echo =                                                                         =
Echo =    1.) NINTENDO                                                         =
echo =                                                                         =
echo =    2.) SEGA                                                             =
echo =                                                                         =
echo =    3.) SONY                                                             =
echo =                                                                         =
echo =    4.) OTHER                                                            =
echo =                                                                         =
echo =                                                                         =
echo =    5.) RETURN TO PREVIOUS MENU                                          =
echo =                                                                         =
echo ===========================================================================
CHOICE /N /C:12345 /M "Enter Corresponding Menu choice (1, 2, 3, 4, 5)"
IF ERRORLEVEL ==5 GOTO ScraperMenu
IF ERRORLEVEL ==4 GOTO OtherScrapeList
IF ERRORLEVEL ==3 GOTO SonyScrapeList
IF ERRORLEVEL ==2 GOTO SegaScrapeList
IF ERRORLEVEL ==1 GOTO NintendoScrapeList

:NintendoScrapeList
cls
echo ===========================================================================
echo =                                                                         =
Echo =    1.) CONSOLE                                                          =
echo =                                                                         =
echo =    2.) PORTABLE                                                         =
echo =                                                                         =
echo =                                                                         =
echo =    3.) RETURN TO PREVIOUS MENU                                          =
echo =                                                                         =
echo ===========================================================================
CHOICE /N /C:123 /M "Enter Corresponding Menu choice (1, 2, 3)"
IF ERRORLEVEL ==3 GOTO ScraperSysMenu
IF ERRORLEVEL ==2 GOTO NintendoScrapeListPortable
IF ERRORLEVEL ==1 GOTO NintendoScrapeListConsole

:NintendoScrapeListConsole
cls
echo ===========================================================================
echo =                                                                         =
Echo =    1.) NES                                                              =
Echo =    2.) FAMICOM DISK SYSTEM                                              =
echo =    3.) SNES                                                             =
echo =    4.) VIRTUAL BOY                                                      =
echo =    5.) NINTENDO 64                                                      =
echo =    6.) GAMECUBE                                                         =
echo =    7.) WII                                                              =
echo =    8.) WII U                                                            =
echo =                                                                         =
echo =    9.) RETURN TO PREVIOUS MENU                                          =
echo =                                                                         =
echo ===========================================================================
CHOICE /N /C:123456789 /M "Enter Corresponding Menu choice (1, 2, 3, 4, 5, 6, 7, 8, 9)"
IF ERRORLEVEL ==9 GOTO NintendoScrapeList
IF ERRORLEVEL ==8 goto NoFeat
IF ERRORLEVEL ==7 goto NoFeat
IF ERRORLEVEL ==6 goto GCScrape
IF ERRORLEVEL ==5 goto N64Scrape
IF ERRORLEVEL ==4 goto VBOYScrape
IF ERRORLEVEL ==3 goto SNESScrape
IF ERRORLEVEL ==2 goto FDSScrape
IF ERRORLEVEL ==1 goto NesScrape


:NintendoScrapeListPortable
cls
echo ===========================================================================
echo =                                                                         =
Echo =    1.) GAMEBOY                                                          =
Echo =    2.) GAMEBOY COLOR                                                    =
echo =    3.) GAMEBOY ADVANCE                                                  =
echo =    4.) NINTENDO DS                                                      =
echo =    5.) NINTENDO 3DS                                                     =
echo =    6.) NINTENDO Switch                                                  =
echo =                                                                         =
echo =    7.) RETURN TO PREVIOUS MENU                                          =
echo =                                                                         =
echo ===========================================================================
CHOICE /N /C:1234567 /M "Enter Corresponding Menu choice (1, 2, 3, 4, 5, 6, 7)"
IF ERRORLEVEL ==7 goto NintendoScrapeList
IF ERRORLEVEL ==6 goto NoFeat
IF ERRORLEVEL ==5 goto 3DSScrape
IF ERRORLEVEL ==4 goto DSScrape
IF ERRORLEVEL ==3 goto GBAScrape
IF ERRORLEVEL ==2 goto GBCScrape
IF ERRORLEVEL ==1 goto GBScrape


:SegaScrapeList
goto NoFeat 


:SonyScrapeList
goto NoFeat


:OtherScrapeList
goto NoFeat


::=================================================================================================================================================================================================================================================================================================================
::==============================================
:: Informational Echoes
::==============================================
:InvalidInput
cls
color FC
echo ==============INVALID INPUT================
echo -------------------------------------------
echo Please select a number from the menu or 
echo select 'Q' to quit.
echo -------------------------------------------
echo ========PRESS ANY KEY TO CONTINUE==========
pause >nul
goto Main
::==============================================
:crash
::yells at you if there is an error, should only show if the script totally failed and ran through to the end somehow
cls
color FC
echo ===========================================
echo =          SOMETHING WENT WRONG :O        =
echo ===========================================
echo      Press any key to return to main menu
pause >nul
goto Main
::==============================================
:ESInstallTotalFailure
cls
color FC
echo ===========================================
echo -------------------------------------------
echo Unable to install any version of Emulation-
echo station. Please create an issue on github
echo with your OS, 64/32 bit, and script 
echo version.                         
echo -------------------------------------------
echo ===========================================
echo      Press any key to return to main menu
pause >nul
goto Main
::==============================================
:completed
::Lets you know when a selected operation is done.
cls
color 0F
echo ===========================================
echo =            OPERATION COMPLETED!         =
echo ===========================================
echo      Press any key to return to main menu
pause >nul
goto Main
::==============================================
:cancelled
::Appears when an operation is canceled.
cls
color FC
echo ===========================================
echo =            OPERATION CANCELLED          =
echo ===========================================
echo      Press any key to return to main menu
pause >nul
goto Main
::==============================================
:NoFeat
::Used for dummy menu item.
cls
color FC
echo ===========================================
echo =    THIS FEATURE IS NOT YET IMPLEMENTED  =
echo ===========================================
echo      Press any key to return to main menu
pause >nul
goto Main
::==============================================
:Disabled
::Used for a feature that is temporarily disabled
cls
echo ==============================================
echo =                                            =
echo = Currently Disabled due to dependency issue =
echo =                                            =
echo ==============================================
echo      Press any key to return to main menu
pause >nul
goto Main
::==============================================
:UpToDate
::Lets the user know emulationstation is up to date and does not need updates.
cls
color 0F
echo ===========================================
echo =            YOU ARE UP TO DATE!          = 
echo ===========================================
echo      Press any key to return to main menu
pause >nul
goto Main
::==============================================
:CleanAllExit
::Lets you know all files are removed. exits the bat file.
cls
color 0F
echo ===========================================
echo -------------------------------------------
echo CLEANUP COMPLETE, PLEASE RESTART RP4Win.BAT
echo IF YOU HAD ANYTHING IN: %romsDir%
echo THEY ARE NOW IN C:\ROMS
echo -------------------------------------------
echo ===========================================
echo            Press Any Key to Exit
pause >nul
cls
exit
::==============================================
:WGETerror
::Throws error if wget fails to download
cls
echo =============================================
echo =                                           =
echo =           WGET DOWNLOAD FAILED            =
echo =   YELL AT IRONMINE86 TO UPDATE THE URL    =
echo =                                           =
echo =============================================
echo            Press Any Key to Exit
pause >nul
cls
exit
::==============================================
:7zerror
::Throws error if 7z fails to download
cls
echo =
echo =============================================
echo =                                           =
echo =            7Z DOWNLOAD FAILED             =
echo =   YELL AT IRONMINE86 TO UPDATE THE URL    =
echo =                                           =
echo =============================================
echo =
echo            Press Any Key to Exit
pause >nul
cls
exit
::==============================================
:GITerror
::Throws error if GIT fails to download
cls
echo =
echo =============================================
echo =                                           =
echo =           GIT DOWNLOAD FAILED             =
echo =   YELL AT IRONMINE86 TO UPDATE THE URL    =
echo =                                           =
echo =============================================
echo =
echo            Press Any Key to Exit
pause >nul
cls
exit
::==============================================
:NoAdmin
::Yells at you for not running as admin. Shame on you.
cls
color FC
echo =
echo =============================================
echo -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
echo * PLEASE RUN THIS PROGRAM AS ADMINISTRATOR. *
echo -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
echo =============================================
echo =
echo            Press Any Key to Exit
pause >nul
cls
exit
::==============================================
:Quit
cls
color 0F
echo =
echo ===========================================
echo --------------- THANK YOU -----------------
echo ===========================================
echo =
echo            Press Any Key to Exit
pause >nul
cls
exit
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================