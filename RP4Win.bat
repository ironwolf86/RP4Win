::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Based on Flerp/RetroCake at https://github.com/Flerp/RetroCake                                        
:: Modified By: ironwolf86
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::Welcome to the RP4Win script!:::::::::::::::::::::::::::::::::::::::::
::I have commented as much as I think is needed, but if there is any confusion just message me through github!::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@ECHO OFF
:: Start program maximized in a new window, if not set in command line call to program
IF NOT "%1" == "max" START /MAX cmd.exe /c %0 max & EXIT /B 1
:AdminCheck
::Checks if the batch file was run as admin. If not it yells at you and will exit.
net session >NUL 2>&1
IF %errorLevel% ==0 (
	GOTO setvars
) ELSE (
	GOTO NoAdmin
)
::==============================================
::==============================================
::==============================================
::==============================================
::==============================================
:: Informational Echoes
::==============================================
:NoAdmin
::Yells at you for not running as admin. Shame on you.
CLS
COLOR FC
echo =
echo =
echo =
echo =
echo =============================================
echo  * * * * * * * * * * * * * * * * * * * * * *
echo * PLEASE RUN THIS PROGRAM AS ADMINISTRATOR. *
echo  * * * * * * * * * * * * * * * * * * * * * *
echo =============================================
echo =
echo =    PRESS ANY KEY TO EXIT
echo =
PAUSE >NUL
CLS
EXIT /B 1
::==============================================
::==============================================
:InvalidInput
CLS
COLOR FC
echo =
echo =
echo =
echo =
echo =============================================
echo =    INVALID INPUT
echo ---------------------------------------------
echo =
echo =    Please type a valid input
echo =    or reenter selection.
echo =
echo =    Type 'Q' to quit.
echo =
echo ---------------------------------------------
echo =
echo =    PRESS ANY KEY TO CONTINUE
echo =
PAUSE >NUL
GOTO AdminCheck
::==============================================
::==============================================
:completed
::Lets you know when a selected operation is done.
CLS
COLOR 0F
echo =
echo =
echo =
echo =
echo =============================================
echo =    OPERATION COMPLETED!
echo =============================================
echo =
echo =    Press any key to return to main menu
echo =
PAUSE >NUL
GOTO Main
::==============================================
::==============================================
:cancelled
::Appears when an operation is canceled.
CLS
COLOR FC
echo =
echo =
echo =
echo =
echo =============================================
echo =    OPERATION CANCELLED!!
echo =============================================
echo =
echo =    Press any key to return to main menu
echo =
PAUSE >NUL
GOTO Main
::==============================================
::==============================================
:NoFeat
::Used for dummy menu item.
CLS
COLOR FC
echo =
echo =
echo =
echo =
echo =============================================
echo =    THIS FEATURE IS NOT YET IMPLEMENTED  
echo =============================================
echo =
echo =    Press any key to return to main menu
echo =
PAUSE >NUL
GOTO Main
::==============================================
::==============================================
:Disabled
::Used for a feature that is temporarily disabled
CLS
COLOR FC
echo =
echo =
echo =
echo =
echo =============================================
echo =    Currently Disabled due to dependency issue 
echo =============================================
echo =
echo =    Press any key to return to main menu
echo =
PAUSE >NUL
GOTO Main
::==============================================
::==============================================
:crash
::yells at you if there is an error, should only show if the script totally failed and ran through to the end somehow
CLS
COLOR FC
echo =
echo =
echo =
echo =
echo =============================================
echo =    SOMETHING WENT WRONG :O
echo =============================================
echo =
echo =    PRESS ANY KEY TO EXIT
echo =
PAUSE >NUL
CLS
EXIT /B 1
::==============================================
::==============================================
:Quit
CLS
COLOR 0F
echo =
echo =
echo =
echo =
echo =============================================
echo --------------- THANK YOU -----------------
echo =============================================
echo =
echo =    PRESS ANY KEY TO EXIT
echo =
PAUSE >NUL
CLS
EXIT /B 0
::==============================================
::==============================================
::==============================================
::==============================================
:setvars
PROMPT $P$G
TITLE RP4Win (Retropie - Windows Edition)
SET rp4winversion=0.6beta
SET lastMod="March 23, 2022"
SET raVERSION=1.10.2
::Sets date and time variables for the backup files
::Important:  This results a fixed day/time stamp as environment variable while in current batch script session.
::E.g., it captures the exact day/time this script started, and then this environment variable becomes reusable
::until this script is closed or invoke time refresh.  Will improve on this later on.
SET CurDate=%date:~4,10%
SET CurTime=%time:~0,8%
SET FormDate=%CurDate:/=%
SET FormTime=%CurTime::=%
:: Display logo
CLS
COLOR 04
echo "                                                       "
echo "          ____  ____  _  ___        ___                "
echo "         |  _ \|  _ \| || \ \      / (_)_ __           "
echo "         | |_) | |_) | || |\ \ /\ / /| | '_ \          "
echo "         |  _ <|  __/|__   _\ V  V / | | | | |         "
echo "         |_| \_\_|      |_|  \_/\_/  |_|_| |_|         "
echo "                                                       "
echo "           .-/+ssyso+/.        ./+osyss+/-.            "
echo "         .hhdos+/-:-+/shds.  .ydhs/+-:-/+osdyh`        "
echo "         :Mo   ``       `+m-:m/`       ``  `sM-        "
echo "         .Mh`   `-::.     +NN/     .::-`   `dN`        "
echo "          +N+      `:o+-  +MM:  -oo:`      oN/         "
echo "           oNo.       .+hhNMMNhh+.       .sN+          "
echo "            -hh+.     `+MMMMMMMN/`     -ohh-           "
echo "             `-hNmsoshmMNhyssydNMmhsoymms-`            "
echo "             :hds/-.-dN+.`    `-sm/.-:ohd/             "
echo "            oN+`  `/dMd.        .mmo.  `/my`           "
echo "           -Mo  -omNmmmdho////oshddmms-  :M+           "
echo "           oM++hNmo-.``.:yMMMN+.```.:smdo:Mh`          "
echo "         -ydymMMy.        \MM/        -mMmohd+`        "
echo "        /Ns. /Mm`         :MM:         -Ms  :mh`       "
echo "       .Ny   -Mh          sMMs         `My   :M+       "
echo "       -M+   +MN-       .sMMMMs.      `sMm   .Ms       "
echo "       `dd` .mMMNy/-.-/shy+/\+shy+:-:odMMM+ `sN-       "
echo "        .dd+dmhdmMMMNMN/`      `/mMMMMds++yshm:        "
echo "         `mMh`  ./hMMM/          /MMd:`   `mM:         "
echo "          :Ms      /NM:          /Ms`      hm          "
echo "           hm.      :Mm-`      `:my       :No          "
echo "           `hm:`     mMMho/::/sdMM/     `+ms           "
echo "             \dds+::sMMNmhyyyyhmNMm/:/+ymy:            "
echo "               \yNMMMs.        `hMMNd+:`               "
echo "                 `:odm+.      -sNs/.                   "
echo "                     -sddhyyhmh+`                      "
echo "                         `...`                         "
echo "                                                       "
echo "               PRESS ANY KEY TO CONTINUE               "
PAUSE >NUL
GOTO CusInstallCheck
:CusInstallCheck
::Checks dummy file in AppData for a custom install directory.
IF EXIST "%APPDATA%\RP4Win\CusInstallDir.txt" GOTO PullCusDir
IF EXIST "C:\RP4Win\RP4Win" GOTO CusInstallN
GOTO CusInstall
:PullCusDir
::Pulls the directory string from a custom install text file.
SET /P rp4winDir=<%APPDATA%\RP4Win\CusInstallDir.txt
IF EXIST "%APPDATA%\RP4Win\CusRomDir.txt" GOTO PullRomDir
GOTO CheckRP4Win
:CusInstall
::Prompts to install in a custom directory or default C:\RP4Win.
CLS
COLOR 07
echo =
echo =
echo =
echo =
echo ==============================================
echo =    INSTALL RP4Win TO A STORAGE DEVICE      =
echo ==============================================
echo =                                            =
echo =    *!IMPORTANT!!*                          =
echo =    This will download and install some     =
echo =    tools to the chosen path!               =
echo =                                            =
echo =--------------------------------------------=
echo =                                            =
echo =    1.) DEFAULT PATH                        =
echo =        (C:\RP4Win)                         =
echo =                                            =
echo =--------------------------------------------=
echo =                                            =
echo =    2.) CUSTOM PATH                         =
echo =        (Select drive for RP4Win install)   =
echo =                                            =
echo =--------------------------------------------=
echo =                                            =
echo =    Press Q to quit                         =
echo =                                            =
CHOICE /C:12Q /N /M "=->  Enter selection (1,2,Q): "
IF ERRORLEVEL ==3 GOTO Quit
IF ERRORLEVEL ==2 GOTO CusInstallY
IF ERRORLEVEL ==1 GOTO CusInstallN
GOTO InvalidInput
:CusInstallY
::Prompts to enter the custom installation path.
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =    CUSTOM INSTALL DIRECTORY                =
echo ==============================================
echo =                                            =
echo =    Enter the letter only of the            =
echo =    drive you wish to use.                  =
echo =                                            =
echo =    Example: D:\                            =
echo =                                            =
echo =    You would type D ...                    =
echo =                                            =
echo =--------------------------------------------=
echo =                                            =
CHOICE /C:ABCDEFGHIJKLMNOPQRSTUVWXYZ /N /CS /M "=->  Letter of drive you wish to use: "
IF ERRORLEVEL ==26 SET rp4winDir=Z:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==25 SET rp4winDir=Y:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==24 SET rp4winDir=X:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==23 SET rp4winDir=W:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==22 SET rp4winDir=V:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==21 SET rp4winDir=U:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==20 SET rp4winDir=T:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==19 SET rp4winDir=S:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==18 SET rp4winDir=R:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==17 SET rp4winDir=Q:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==16 SET rp4winDir=P:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==15 SET rp4winDir=O:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==14 SET rp4winDir=N:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==13 SET rp4winDir=M:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==12 SET rp4winDir=L:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==11 SET rp4winDir=K:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==10 SET rp4winDir=J:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==9 SET rp4winDir=I:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==8 SET rp4winDir=H:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==7 SET rp4winDir=G:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==6 SET rp4winDir=F:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==5 SET rp4winDir=E:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==4 SET rp4winDir=D:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==3 SET rp4winDir=C:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==2 SET rp4winDir=B:\RP4Win & GOTO writeInstDir
IF ERRORLEVEL ==1 SET rp4winDir=A:\RP4Win & GOTO writeInstDir
GOTO InvalidInput
:writeInstDir
::writes the directory to %APPDATA%\RP4Win\ for use when launching the bat file.
IF NOT EXIST %APPDATA%\RP4Win\ MKDIR "%APPDATA%\RP4Win"
IF EXIST "%APPDATA%\RP4Win\CusInstallDir.txt" DEL "%APPDATA%\RP4Win\CusInstallDir.txt"
::removes trailing space
SET rp4winDir=%rp4winDir:~0,-1%
echo %rp4winDir%>"%APPDATA%\RP4Win\CusInstallDir.txt"
GOTO CheckRP4Win
:CusInstallN
::Sets the install path to default C:\RP4Win
SET rp4winDir=C:\RP4Win
GOTO CheckRP4Win
:CheckRP4Win
::Checks if RP4Win is already installed
IF EXIST %rp4winDir%\Temp\ GOTO permcheck
GOTO SetupRPDir
:SetupRPDir
::Creates the directories needed for installation, then sets the permissions to Everyone R/W for use with the shares.
IF NOT EXIST %rp4winDir%\ MKDIR "%rp4winDir%"
IF NOT EXIST %rp4winDir%\Temp\ MKDIR "%rp4winDir%\Temp"
IF NOT EXIST %rp4winDir%\Backup\ MKDIR "%rp4winDir%\Backup"
IF NOT EXIST %rp4winDir%\Tools\ MKDIR "%rp4winDir%\Tools"
IF NOT EXIST %rp4winDir%\RetroArch\ MKDIR "%rp4winDir%\RetroArch"
IF NOT EXIST %rp4winDir%\EmulationStation\ MKDIR "%rp4winDir%\EmulationStation"
IF NOT EXIST %rp4winDir%\EmulationStation\.emulationstation\ MKDIR "%rp4winDir%\EmulationStation\.emulationstation"
IF NOT EXIST %rp4winDir%\EmulationStation\.emulationstation\roms\ MKDIR "%rp4winDir%\EmulationStation\.emulationstation\roms"
ICACLS "%rp4winDir%" /grant everyone:(OI)(CI)F /T
echo pls no delete>"%rp4winDir%\RP4Win"
GOTO Tools
:permcheck
::Changes permissions to Everyone R/W for use with the shares, secondary check for already installed just in case.
IF EXIST "%rp4winDir%\RP4Win" GOTO Tools
GOTO permss
:permss
::Changes permissions to Everyone R/W for use with the shares, secondary check for already installed just in case.
echo =
echo =    Checking file/folder permissions and 
echo =    changing them to 'Everyone' as needed.
echo =
echo =    This ensures that the user can access
echo =    and modify all files and folders within
echo =    RP4Win directory.
echo = 
echo =    Please Wait...
echo =
ICACLS "%rp4winDir%" /grant everyone:(OI)(CI)F /T
echo pls no delete>"%rp4winDir%\RP4Win"
TIMEOUT /T 5
GOTO Tools
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Tools
SET tempDir=%rp4winDir%\Temp
SET toolsDir=%rp4winDir%\Tools
SET RADir=%rp4winDir%\RetroArch	
SET esDir=%rp4winDir%\EmulationStation
SET systemsDir=%esDir%\Emulators
SET romsDir=%esDir%\.emulationstation\roms
SET themesDir=%esDir%\.emulationstation\themes
COLOR 07
GOTO check7z
::==============================================
::==============================================
:check7z
::Checks for 7z installation. (needed to use the bat file.)
IF EXIST "%toolsDir%\7za\7za.exe" GOTO WGETCheck
::Checks if installation is x86 or x86_64
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO install7z64
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO install7z32
	)
:install7z64
::Installs 7z with pretty information.
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    SETTING UP 7ZA 64BIT             
echo =
echo ==============================================
IF NOT EXIST %toolsDir%\7za\ MKDIR "%toolsDir%\7za"
::Pulls 7za and unzips via powershell. (All future unzipping is done with 7za, as it is faster and cleaner.)
powershell -command (New-Object Net.WebClient).DownloadFile('https://github.com/ironwolf86/RP4Win/blob/main/7zip/7z2107_x64.zip?raw=true','%tempDir%\7za.zip')
ping 127.0.0.1 -n 3 >NUL
powershell -command (New-Object -ComObject shell.application).namespace('%toolsDir%\7za').CopyHere((New-Object -ComObject shell.application).namespace('%tempDir%\7za.zip').Items(),16)
echo =
echo =
echo =
echo =
echo ==============================================
echo =    Cleaning up downloaded file(s)      
echo ==============================================
::Waits for the zip to be fully closed
ping 127.0.0.1 -n 2 >NUL
::Deletes downloaded zip
IF EXIST "%tempDir%\7za.zip" DEL "%tempDir%\7za.zip"
TIMEOUT /T 5
IF EXIST "%toolsDir%\7za\7za.exe" GOTO WGETCheck
GOTO 7zerror
:install7z32
::Installs 7z with pretty information.
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    SETTING UP 7ZA 32BIT             
echo =
echo ==============================================
IF NOT EXIST %toolsDir%\7za\ MKDIR "%toolsDir%\7za"
::Pulls 7za and unzips via powershell. (All future unzipping is done with 7za, as it is faster and cleaner.)
powershell -command (New-Object Net.WebClient).DownloadFile('https://github.com/ironwolf86/RP4Win/blob/main/7zip/7z2107_x86.zip?raw=true','%tempDir%\7za.zip')
ping 127.0.0.1 -n 3 >NUL
powershell -command (New-Object -ComObject shell.application).namespace('%toolsDir%\7za').CopyHere((New-Object -ComObject shell.application).namespace('%tempDir%\7za.zip').Items(),16)
echo =
echo =
echo =
echo =
echo ==============================================
echo =    Cleaning up downloaded file(s)      
echo ==============================================
::Waits for the zip to be fully closed
ping 127.0.0.1 -n 2 >NUL
::Deletes downloaded zip
IF EXIST "%tempDir%\7za.zip" DEL "%tempDir%\7za.zip"
TIMEOUT /T 5
IF EXIST "%toolsDir%\7za\7za.exe" GOTO WGETCheck
GOTO 7zerror
::==============================================
:7zerror
::Throws error if 7z fails to download
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =                                           
echo =    7Z DOWNLOAD FAILED             
echo =    YELL AT IRONMINE86 TO UPDATE THE SCRIPT    
echo =                                           
echo ==============================================
echo =
echo =          Press Any Key to Exit
PAUSE >NUL
CLS
EXIT /B 1
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:WGETCheck
IF EXIST "%toolsDir%\Wget\wget.exe" GOTO SGitCheck
::Checks if installation is x86 or x86_64
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO wget64
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO wget32
	)
:wget64
::Installs wget binaries with pretty information.
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    SETTING UP WGET 64BIT               
echo =
echo ==============================================
IF NOT EXIST %toolsDir%\Wget\ MKDIR "%toolsDir%\Wget"
::Pulls wget binaries via powershell. 
powershell -command (New-Object Net.WebClient).DownloadFile('https://github.com/ironwolf86/RP4Win/blob/main/wget/wget-1.20.3-win64.zip?raw=true','%tempDir%\Wget.zip')
ping 127.0.0.1 -n 3 >NUL
::Unzip downloaded file to the Tools directory
%toolsDir%\7za\7za.exe x "%tempDir%\Wget.zip" -o"%toolsDir%\Wget" -aoa >NUL
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Cleaning up downloaded file(s)      
echo ===========================================
::Waits for the zip to be fully closed
ping 127.0.0.1 -n 2 >NUL
::Deletes downloaded zip
IF EXIST "%tempDir%\Wget.zip" DEL "%tempDir%\Wget.zip"
TIMEOUT /T 5
IF EXIST "%toolsDir%\Wget\wget.exe" GOTO SGitCheck
GOTO WGETerror
:wget32
::Installs wget binaries with pretty information.
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    SETTING UP WGET 32BIT               
echo =
echo ==============================================
IF NOT EXIST %toolsDir%\Wget\ MKDIR "%toolsDir%\Wget"
::Pulls wget binaries via powershell.
powershell -command (New-Object Net.WebClient).DownloadFile('https://github.com/ironwolf86/RP4Win/blob/main/wget/wget-1.20.3-win32.zip?raw=true','%tempDir%\Wget.zip')
ping 127.0.0.1 -n 3 >NUL
::Unzip downloaded file to the Tools directory
%toolsDir%\7za\7za.exe x "%tempDir%\Wget.zip" -o"%toolsDir%\Wget" -aoa >NUL
echo =
echo =
echo =
echo =
echo ==============================================
echo =    Cleaning up downloaded file(s)      
echo ==============================================
::Waits for the zip to be fully closed
ping 127.0.0.1 -n 2 >NUL
::Deletes downloaded zip
IF EXIST "%tempDir%\Wget.zip" DEL "%tempDir%\Wget.zip"
TIMEOUT /T 5
IF EXIST "%toolsDir%\Wget\wget.exe" GOTO SGitCheck
GOTO WGETerror
::==============================================
:WGETerror
::Throws error if wget fails to download
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =                                           
echo =    WGET DOWNLOAD FAILED            
echo =    YELL AT IRONMINE86 TO UPDATE THE SCRIPT   
echo =                                           
echo ==============================================
echo =
echo =          Press Any Key to Exit
PAUSE >NUL
CLS
EXIT /B 1
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:SGitCheck
::Checks if git is installed (Used for various functions in the bat file)
IF EXIST "%toolsDir%\git\bin\git.exe" GOTO VCREDISTCheck
::Checks if installation is x86 or x86_64
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO sgit64
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO sgit32
	)
:sgit64
::Installs git binaries with pretty information.
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    SETTING UP GIT 64BIT             
echo =
echo ==============================================
%toolsDir%\Wget\wget.exe -q https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/PortableGit-2.35.1.2-64-bit.7z.exe -O "%tempDir%\git.exe"
ping 127.0.0.1 -n 3 >NUL
IF NOT EXIST %toolsDir%\git\ MKDIR "%toolsDir%\git"
::Unzip downloaded file to the Tools directory
%toolsDir%\7za\7za.exe x "%tempDir%\git.exe" -o"%toolsDir%\git" -aoa >NUL
echo =
echo =
echo =
echo =
echo ==============================================
echo =    Cleaning up downloaded file(s)      
echo ==============================================
::Waits for the zip to be fully closed
ping 127.0.0.1 -n 2 >NUL
::Deletes downloaded zip
IF EXIST "%tempDir%\git.exe" DEL "%tempDir%\git.exe"
TIMEOUT /T 5
IF EXIST "%toolsDir%\git\bin\git.exe" GOTO VCREDISTCheck
GOTO GITerror
:sgit32
::Installs git binaries with pretty information.
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    SETTING UP GIT 32BIT             
echo =
echo ==============================================
%toolsDir%\Wget\wget.exe -q https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/PortableGit-2.35.1.2-32-bit.7z.exe -O "%tempDir%\git.exe"
ping 127.0.0.1 -n 3 >NUL
IF NOT EXIST %toolsDir%\git\ MKDIR "%toolsDir%\git"
::Unzip downloaded file to the Tools directory
%toolsDir%\7za\7za.exe x "%tempDir%\git.exe" -o"%toolsDir%\git" -aoa >NUL
echo =
echo =
echo =
echo =
echo ==============================================
echo =    Cleaning up downloaded file(s)      
echo ==============================================
::Waits for the zip to be fully closed
ping 127.0.0.1 -n 2 >NUL
::Deletes downloaded zip
IF EXIST "%tempDir%\git.exe" DEL "%tempDir%\git.exe"
TIMEOUT /T 5
IF EXIST "%toolsDir%\git\bin\git.exe" GOTO VCREDISTCheck
GOTO GITerror
::==============================================
:GITerror
::Throws error if GIT fails to download
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =                                           
echo =    GIT DOWNLOAD FAILED             
echo =    YELL AT IRONMINE86 TO UPDATE THE SCRIPT    
echo =                                           
echo ==============================================
echo =
echo =          Press Any Key to Exit
PAUSE >NUL
CLS
EXIT /B 1
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:VCREDISTCheck
::Checks if RP4Win has installed the Visual Studio redistributables
IF EXIST "%toolsDir%\VC" GOTO DirectXSetupCheck
CLS
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO VCRedistInstall64
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO VCRedistInstall32
	)
:VCRedistInstall64
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    SETTING UP VC REDIST 64BIT         
echo =
echo ==============================================
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/C/6/D/C6D0FD4E-9E53-4897-9B91-836EBA2AACD3/vcredist_x86.exe -O "%tempDir%\VC_Redist_2010_32.exe"
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/A/8/0/A80747C3-41BD-45DF-B505-E9710D2744E0/vcredist_x64.exe -O "%tempDir%\VC_Redist_2010_64.exe"
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe -O "%tempDir%\VC_Redist_2012_32.exe"
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe -O "%tempDir%\VC_Redist_2012_64.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/highdpimfc2013x86enu -O "%tempDir%\VC_Redist_2013_32.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/highdpimfc2013x64enu -O "%tempDir%\VC_Redist_2013_64.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/vs/17/release/vc_redist.x86.exe -O "%tempDir%\latest_32.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/vs/17/release/vc_redist.x64.exe -O "%tempDir%\latest_64.exe"
ping 127.0.0.1 -n 3 >NUL
echo VC Redist 64bit Installed>"%toolsDir%\VC"
echo ------------------------->>"%toolsDir%\VC"
%tempDir%\VC_Redist_2010_32.exe /install /quiet
echo VC_Redist_2010_32.exe>>"%toolsDir%\VC"
%tempDir%\VC_Redist_2010_64.exe /install /quiet
echo VC_Redist_2010_64.exe>>"%toolsDir%\VC"
%tempDir%\VC_Redist_2012_32.exe /install /quiet
echo VC_Redist_2012_32.exe>>"%toolsDir%\VC"
%tempDir%\VC_Redist_2012_64.exe /install /quiet
echo VC_Redist_2012_64.exe>>"%toolsDir%\VC"
%tempDir%\VC_Redist_2013_32.exe /install /quiet
echo VC_Redist_2013_32.exe>>"%toolsDir%\VC"
%tempDir%\VC_Redist_2013_64.exe /install /quiet
echo VC_Redist_2013_64.exe>>"%toolsDir%\VC"
%tempDir%\latest_32.exe /install /quiet
echo latest_32.exe>>"%toolsDir%\VC"
%tempDir%\latest_64.exe /install /quiet
echo latest_64.exe>>"%toolsDir%\VC"
echo =
echo =
echo =
echo =
echo ==============================================
echo =    Cleaning up downloaded file(s)      
echo ==============================================
ping 127.0.0.1 -n 3 >NUL
IF EXIST "%tempDir%\VC_Redist_2010_32.exe" DEL "%tempDir%\VC_Redist_2010_32.exe"
IF EXIST "%tempDir%\VC_Redist_2010_64.exe" DEL "%tempDir%\VC_Redist_2010_64.exe"
IF EXIST "%tempDir%\VC_Redist_2012_32.exe" DEL "%tempDir%\VC_Redist_2012_32.exe"
IF EXIST "%tempDir%\VC_Redist_2012_64.exe" DEL "%tempDir%\VC_Redist_2012_64.exe"
IF EXIST "%tempDir%\VC_Redist_2013_32.exe" DEL "%tempDir%\VC_Redist_2013_32.exe"
IF EXIST "%tempDir%\VC_Redist_2013_64.exe" DEL "%tempDir%\VC_Redist_2013_64.exe"
IF EXIST "%tempDir%\latest_32.exe" DEL "%tempDir%\latest_32.exe"
IF EXIST "%tempDir%\latest_64.exe" DEL "%tempDir%\latest_64.exe"
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    THESE FILES ARE NOT UNINSTALLED WITH THE 
echo =    "REMOVE ALL RP4Win FILES" SCRIPT. AS THEY
echo =    ARE GENERALLY USED BY OTHER PROGRAMS.
echo =
echo ==============================================
TIMEOUT /T 10
GOTO DirectXSetupCheck
:VCRedistInstall32
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    SETTING UP VC REDIST 32BIT         
echo =
echo ==============================================
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/C/6/D/C6D0FD4E-9E53-4897-9B91-836EBA2AACD3/vcredist_x86.exe -O "%tempDir%\VC_Redist_2010_32.exe"
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe -O "%tempDir%\VC_Redist_2012_32.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/highdpimfc2013x86enu -O "%tempDir%\VC_Redist_2013_32.exe"
%toolsDir%\Wget\wget.exe -q https://aka.ms/vs/17/release/vc_redist.x86.exe -O "%tempDir%\latest_32.exe"
ping 127.0.0.1 -n 3 >NUL
echo VC Redist 32bit Installed>"%toolsDir%\VC"
echo ------------------------->>"%toolsDir%\VC"
%tempDir%\VC_Redist_2010_32.exe /install /quiet
echo VC_Redist_2010_32.exe>>"%toolsDir%\VC"
%tempDir%\VC_Redist_2012_32.exe /install /quiet
echo VC_Redist_2012_32.exe>>"%toolsDir%\VC"
%tempDir%\VC_Redist_2013_32.exe /install /quiet
echo VC_Redist_2013_32.exe>>"%toolsDir%\VC"
%tempDir%\latest_32.exe /install /quiet
echo latest_32.exe>>"%toolsDir%\VC"
echo =
echo =
echo =
echo =
echo ==============================================
echo =     Cleaning up downloaded file(s)      
echo ==============================================
ping 127.0.0.1 -n 3 >NUL
IF EXIST "%tempDir%\VC_Redist_2010_32.exe" DEL "%tempDir%\VC_Redist_2010_32.exe"
IF EXIST "%tempDir%\VC_Redist_2012_32.exe" DEL "%tempDir%\VC_Redist_2012_32.exe"
IF EXIST "%tempDir%\VC_Redist_2013_32.exe" DEL "%tempDir%\VC_Redist_2013_32.exe"
IF EXIST "%tempDir%\latest_32.exe" DEL "%tempDir%\latest_32.exe"
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    THESE FILES ARE NOT UNINSTALLED WITH THE 
echo =    "REMOVE ALL RP4Win FILES" SCRIPT. AS THEY
echo =    ARE GENERALLY USED BY OTHER PROGRAMS.
echo =
echo ==============================================
TIMEOUT /T 10
GOTO DirectXSetupCheck
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:DirectXSetupCheck
IF EXIST "%toolsDir%\DX" GOTO Main
CLS
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    SETTING UP DIRECTX             
echo =
echo ==============================================
%toolsDir%\Wget\wget.exe -q https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe  -O "%tempDir%\dxwebsetup.exe"
%tempDir%\dxwebsetup.exe /Q
echo DirectX Installed>"%toolsDir%\DX"
echo =
echo =
echo =
echo =
echo ==============================================
echo =    Cleaning up downloaded file(s)      
echo ==============================================
ping 127.0.0.1 -n 3 >NUL
IF EXIST "%tempDir%\dxwebsetup.exe" DEL "%tempDir%\dxwebsetup.exe"
echo =
echo =
echo =
echo =
echo ==============================================
echo =
echo =    THESE FILES ARE NOT UNINSTALLED WITH THE 
echo =    "REMOVE ALL RP4Win FILES" SCRIPT. AS THEY
echo =    ARE GENERALLY USED BY OTHER PROGRAMS.
echo =
echo ==============================================
TIMEOUT /T 10
GOTO Main
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Main
CLS
COLOR 07
echo =
echo =
echo =
echo =
echo =    Hello %USERNAME%, 
echo =    Welcome to RP4Win v.%rp4winversion%
echo ==============================================
echo =               Main Menu                    =
echo ==============================================
echo =                                            =
echo =    Important:                              =
echo =    This script can and WILL overwrite      =
echo =    your configurations and game data!!     =      
echo =                                            =
echo =    1.) AUTOMATED INSTALLERS                =
echo =                                            =
echo ----------------------------------------------
echo =                                            =
echo =    2.) MANAGE EMULATIONSTATION             =
echo =    3.) MANAGE RETROARCH                    =
echo =    4.) MANAGE ADDITIONAL EMULATORS         =
echo =    5.) MANAGE ROM DIRECTORIES              =
echo =    6.) MANAGE DEDICATED EMUBOX SETTINGS    =
echo =                                            =
echo ----------------------------------------------
echo =                                            =
echo =    7.) SYSTEM CLEANUP                      =
echo =    8.) ROM SCRAPER (non-functional)        =
echo =                                            =
echo ----------------------------------------------
echo =                                            =
echo =    9.) UPDATE RP4WIN SCRIPT                =
echo =                                            =
echo ----------------------------------------------
echo =                                            =
echo =    Q.) Press Q to quit                     =
echo =                                            =
echo      Last Modified: %lastMod%
echo =                                            =
CHOICE /C:123456789Q /N /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,Q): "
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
GOTO crash
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection1
::Menu for automated full installers (Emulationstation + RetroArch + Config Generation + ROM Directory Setup)
CLS
COLOR 07
echo =
echo =
echo =
echo =
echo ===========================================
echo =    AUTOMATED INSTALLERS
echo ===========================================
echo =
echo =    1.) FULL SETUP WITH DEFAULT ROM DIRECTORY
echo =        %romsDir%\
echo =
echo -------------------------------------------
echo =
echo =    2.) FULL SETUP WITH CUSTOM ROM DIRECTORY
echo =        (Path entered during installation)
echo =
echo -------------------------------------------
echo =
echo =    3.) FULL SETUP WITHOUT ROM DIRECTORY 
echo =        (NEED TO EDIT es_systems.cfg)
echo =
echo -------------------------------------------
echo =
echo =    4.) RETURN TO MAIN MENU
echo =
echo ===========================================
echo =
CHOICE /C:1234 /N /T 30 /D 4 /M "=->  Enter selection (1, 2, 3, 4): "
IF ERRORLEVEL ==4 GOTO Main
IF ERRORLEVEL ==3 GOTO NoFeat
IF ERRORLEVEL ==2 GOTO NoFeat
::IF ERRORLEVEL ==3 GOTO Selection1_BrandNewBlank
::IF ERRORLEVEL ==2 GOTO Selection1_BrandNewCus
IF ERRORLEVEL ==1 GOTO Selection1_BrandNewDef
GOTO crash
::==============================================
::==============================================
:Selection1_BrandNewDef
::Creates temporary file to guide the installation process for default installation (ROM directory inside RP4Win directory)
CLS
echo Temp file used for installation. IF you see this file something bad happened>"%tempDir%\BrandNewDef"
GOTO Selection2_updateES
::==============================================
:Selection1_BrandNewCus
::Creates temporary file to guide the installation process for custom ROM directory installation (ROM directory set via variable)
CLS
echo Temp file used for installation. IF you see this file something bad happened>"%tempDir%\BrandNewCus"
GOTO Selection2_updateES
::==============================================
:Selection1_BrandNewBlank
::Creates temporary file to guide the installation process for Blank installation (No es_systems.cfg setup)
CLS
echo Temp file used for installation. IF you see this file something bad happened>"%tempDir%\BrandNewBlank"
GOTO Selection2_updateES
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection2
::Menu for Managing Emulationstation updates, config, and themes.
CLS
COLOR 07
echo =
echo =
echo =
echo =
echo ===========================================
echo =    MANAGE EMULATIONSTATION
echo ===========================================
echo =
echo =    1.) CHECK EMULATIONSTATION FOR UPDATES
echo =
echo -------------------------------------------
echo =
echo =    2.) MANAGE es_systems.cfg FILE
echo =
echo -------------------------------------------
echo =
echo =    3.) MANAGE EMULATIONSTATION THEMES
echo =
echo -------------------------------------------
echo =
echo =    4.) RETURN TO MAIN MENU
echo =
echo ===========================================
echo =
CHOICE /C:1234 /N /T 30 /D 4 /M "=->  Enter selection (1,2,3,4): "
IF ERRORLEVEL ==4 GOTO Main
IF ERRORLEVEL ==3 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==2 GOTO Selection2_ManESCFG
IF ERRORLEVEL ==1 GOTO Selection2_StartESVerCheck
GOTO crash
::==============================================
::==============================================
:Selection2_StartESVerCheck
::Starts checking Emulationstation's version for update. Removes the ESCheck folder to ensure comparison results are good.
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    CHECKING FOR EMULATIONSTATION UPDATES               
echo ===========================================
echo =
IF EXIST %tempDir%\ESCheck\ RMDIR "%tempDir%\ESCheck" /S /Q
GOTO Selection2_ESCheck
::==============================================
:Selection2_ESCheck
::Checks if emulationstation is installed. if not it prompts to install. if already installed downloads a small version of the latest update. Compares the downloaded exe with the installed exe. If different prompts to update
::Accomplishes this version compare by writing the file size of the current exe and the downloaded exe to two text files. Compares the strings in the text files. If they are the same then no update. If they are different then prompts for update.
IF NOT EXIST "%esDir%\emulationstation.exe" GOTO Selection2_UpdateESQN
IF NOT EXIST %tempDir%\ESCheck\ MKDIR "%tempDir%\ESCheck"
%toolsDir%\Wget\wget.exe -q https://github.com/jrassa/EmulationStation/releases/download/continuous-master/EmulationStation-Win32-no-deps.zip -O "%tempDir%\ESCheck\tempES.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\ESCheck\tempES.zip" -o"%tempDir%\ESCheck" -aoa >NUL

FOR %%I IN (%esDir%\emulationstation.exe) DO ECHO %%~zI >"%tempDir%\ESCheck\currentES.txt"
FOR %%I IN (%tempDir%\ESCheck\emulationstation.exe) DO ECHO %%~zI >"%tempDir%\ESCheck\newES.txt"
CD /D "%tempDir%\ESCheck"
SET /P currentES=<currentES.txt
SET /P newES=<newES.txt
ping 127.0.0.1 -n 2 >NUL
IF %currentES%==%newES% GOTO Selection2_ESUpToDate
GOTO Selection2_UpdateESQ
::==============================================
:Selection2_ESUpToDate
::Lets the user know emulationstation is up to date and does not need updates.
CLS
COLOR 0F
echo =
echo =
echo =
echo =
echo ===========================================
echo =    YOU ARE UP TO DATE!          
echo ===========================================
echo =
echo =    PRESS ANY KEY
echo =
PAUSE >NUL
GOTO Selection2
::==============================================
:Selection2_UpdateESQ
::Prompts to update. Sends to Emulationstation installation (Newest available version)
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    AN UPDATE IS AVAILABLE!!
echo ===========================================
echo =
echo =    1.) UPDATES EMULATIONSTATION FILES AND DIRECTORIES
echo =        (Backs up current install to %rp4winDir%\Backup) 
echo =
echo -------------------------------------------
echo =
echo =    2.) RETURN TO MANAGE ES MENU
echo =
echo -------------------------------------------
echo =
echo =    3.) RETURN TO MAIN MENU
echo =
echo ===========================================
echo =
CHOICE /C:123 /N /T 30 /D 3 /M "=->  Enter selection (1,2,3): "
IF ERRORLEVEL ==3 GOTO Main
IF ERRORLEVEL ==2 GOTO Selection2
IF ERRORLEVEL ==1 GOTO Selection2_UpdateES
GOTO crash
::==============================================
:Selection2_UpdateESQN
::Lets the user know that emulationstation is not installed. Prompts for installation. (Newest available version)
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    EMUALATIONSTATION NOT FOUND!!
echo ===========================================
echo =
echo =    1.) INSTALL EMULATIONSTATION TO %esDir%
echo =
echo -------------------------------------------
echo =
echo =    2.) RETURN TO MANAGE ES MENU
echo =
echo -------------------------------------------
echo =
echo =    3.) RETURN TO MAIN MENU
echo =
echo ===========================================
echo =
CHOICE /C:123 /N /T 30 /D 3 /M "=->  Enter selection (1,2,3): "
IF ERRORLEVEL ==3 GOTO Main
IF ERRORLEVEL ==2 GOTO Selection2
IF ERRORLEVEL ==1 GOTO Selection2_UpdateES
GOTO crash
::==============================================
::==============================================
:Selection2_updateES
::Backs up old installation
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =                                                                  
echo =    Backing up EmulationStation folder                          
echo =                                                                  
echo =    If this folder does not exist, it will be skipped             
echo =                                                                  
echo =    please wait...                             
echo =
echo ===========================================
echo =
%toolsDir%\7za\7za.exe a "%rp4winDir%\Backup\ES_Backup_%FormDate%_%FormTime%.zip" "%esDir%"
::Removes old emulationstation files
IF EXIST %esDir%\ RMDIR "%esDir%" /S /Q
IF NOT EXIST %esDir%\ MKDIR "%esDir%"
IF EXIST %toolsDir%\ES-Batocera-Version\ RMDIR "%toolsDir%\ES-Batocera-Version" /S /Q
IF NOT EXIST %toolsDir%\ES-Batocera-Version\ MKDIR "%toolsDir%\ES-Batocera-Version"
::Downloads the latest build of EmulationStation
echo =
echo =
echo =
echo =
echo ===========================================
echo =    DOWNLOADING LATEST BUILD OF ES 
echo ===========================================
echo =                                                                
echo =    Download/Install:                                      
echo =         - EmulationStation (jrassa)                       
echo =         - Carbon theme (RetroPie)                         
echo =         - Slick City Lights theme (RetroHursty69)         
echo =         - CosmicRise theme (RetroHursty69)                
echo =                                                                
echo =                                                                
echo =    Also, Batocera versions of EmulationStation and        
echo =    themes are provided in this directory:           
echo =    %toolsDir%\ES-Batocera-Version
echo =               
echo =         - Batocera-EmulationStation  (fabricecaruso)      
echo =         - Carbon theme  (fabricecaruso)                   
echo =         - Mru5 theme    (kelvinator3300)                  
echo =                                                                
echo =    please wait ...                        
echo =                                                                

%toolsDir%\Wget\wget.exe -q https://github.com/fabricecaruso/batocera-emulationstation/releases/download/continuous-master/EmulationStation-Win32.zip -O "%toolsDir%\ES-Batocera-Version\BES.zip"
ping 127.0.0.1 -n 3 >NUL

::es-toolkit
MKDIR "%tempDir%\EmulationStation"
%toolsDir%\Wget\wget.exe -q https://github.com/mattrixk/es-toolkit/archive/refs/tags/v1.2.zip -O "%tempDir%\estoolkit.zip"
ping 127.0.0.1 -n 3 >NUL
%toolsDir%\7za\7za.exe x "%tempDir%\estoolkit.zip" -o"%tempDir%\EmulationStation" >NUL
::delete unneeded portion of downloaded file
DEL "%tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\README.md"
RMDIR "%tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\.emulationstation" /S /Q
::moves batch file scripts to RP4Win\EmulationStation
MOVE %tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\* %esDir%
:: jdrassa emulationstation
%toolsDir%\Wget\wget.exe -q https://github.com/jrassa/EmulationStation/releases/download/continuous-master/EmulationStation-Win32.zip -O "%tempDir%\ES.zip"
:: Lines below are commented out -- for now.
:: Alternative - comment out the link above and then uncomment this link below when Jrassa's github fails to download
:: This link below pulls previously working build for Windows from AppVeyor site
::%toolsDir%\Wget\wget.exe -q https://ci.appveyor.com/api/buildjobs/ue3rq2weq0re3fqq/artifacts/EmulationStation-Win32.zip -O "%tempDir%\ES.zip"
:: https://ci.appveyor.com/project/jrassa/emulationstation
:: Lines above are commented out -- for now.
ping 127.0.0.1 -n 3 >NUL
::Extracts to the RP4Win\EmulationStation directory
%toolsDir%\7za\7za.exe x "%tempDir%\ES.zip" -o"%esDir%" >NUL
%toolsDir%\7za\7za.exe x "%toolsDir%\ES-Batocera-Version\BES.zip" -o"%toolsDir%\ES-Batocera-Version" >NUL

CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Cleaning up downloaded file(s)        
echo ===========================================
::Cleans up Downloaded zip
IF EXIST "%tempDir%\ES.zip" DEL "%tempDir%\ES.zip"
IF EXIST "%toolsDir%\ES-Batocera-Version\BES.zip" DEL "%toolsDir%\ES-Batocera-Version\BES.zip"
IF EXIST "%tempDir%\estoolkit.zip" DEL "%tempDir%\estoolkit.zip"
IF EXIST %tempDir%\EmulationStation\ RMDIR "%tempDir%\EmulationStation" /S /Q
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Creating shortcut icons on Desktop    
echo ===========================================
::Deletes old shortcut
IF EXIST "%USERPROFILE%\Desktop\RP4Win.lnk" DEL "%USERPROFILE%\Desktop\RP4Win.lnk"
IF EXIST "%USERPROFILE%\Desktop\RP4Win Windowed.lnk" DEL "%USERPROFILE%\Desktop\RP4Win Windowed.lnk"
IF EXIST "%rp4winDir%\RP4Win.lnk" DEL "%rp4winDir%\RP4Win.lnk"
IF EXIST "%rp4winDir%\RP4Win Windowed.lnk" DEL "%rp4winDir%\RP4Win Windowed.lnk"
::Makes two shortcuts on Desktop, to start RRP4Win in full-screen and windowed (EmulationStation icon)
::full screen
echo Set oWS = WScript.CreateObject("WScript.Shell")>"%tempDir%\CreateShortcut.vbs"
echo sLinkFile = "%USERPROFILE%\Desktop\RP4Win.lnk">>"%tempDir%\CreateShortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile)>>"%tempDir%\CreateShortcut.vbs"
echo oLink.TargetPath = "%esDir%\Launch ES Fullscreen.bat">>"%tempDir%\CreateShortcut.vbs"
echo oLink.WorkingDirectory = "%esDir%">>"%tempDir%\CreateShortcut.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe">>"%tempDir%\CreateShortcut.vbs"
echo oLink.Save>>"%tempDir%\CreateShortcut.vbs"
CSCRIPT "%tempDir%\CreateShortcut.vbs"
IF EXIST "%tempDir%\CreateShortcut.vbs" DEL "%tempDir%\CreateShortcut.vbs"
::windowed
echo Set oWS = WScript.CreateObject("WScript.Shell")>"%tempDir%\CreateShortcut2.vbs"
echo sLinkFile = "%USERPROFILE%\Desktop\RP4Win Windowed.lnk">>"%tempDir%\CreateShortcut2.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile)>>"%tempDir%\CreateShortcut2.vbs"
echo oLink.TargetPath = "%esDir%\Launch ES Mid Size (1280x720).bat">>"%tempDir%\CreateShortcut2.vbs"
echo oLink.WorkingDirectory = "%esDir%">>"%tempDir%\CreateShortcut2.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe">>"%tempDir%\CreateShortcut2.vbs"
echo oLink.Save>>"%tempDir%\CreateShortcut2.vbs"
CSCRIPT "%tempDir%\CreateShortcut2.vbs"
IF EXIST "%tempDir%\CreateShortcut2.vbs" DEL "%tempDir%\CreateShortcut2.vbs"

::Makes two shortcuts in RRP4Win folder, to start RRP4Win in full-screen and windowed (EmulationStation icon)
::full screen
echo Set oWS = WScript.CreateObject("WScript.Shell")>"%tempDir%\CreateShortcut3.vbs"
echo sLinkFile = "%rp4winDir%\RP4Win.lnk">>"%tempDir%\CreateShortcut3.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile)>>"%tempDir%\CreateShortcut3.vbs"
echo oLink.TargetPath = "%esDir%\Launch ES Fullscreen.bat">>"%tempDir%\CreateShortcut3.vbs"
echo oLink.WorkingDirectory = "%esDir%">>"%tempDir%\CreateShortcut3.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe">>"%tempDir%\CreateShortcut3.vbs"
echo oLink.Save>>"%tempDir%\CreateShortcut3.vbs"
CSCRIPT "%tempDir%\CreateShortcut3.vbs"
IF EXIST "%tempDir%\CreateShortcut3.vbs" DEL "%tempDir%\CreateShortcut3.vbs"
::windowed
echo Set oWS = WScript.CreateObject("WScript.Shell")>"%tempDir%\CreateShortcut4.vbs"
echo sLinkFile = "%rp4winDir%\RP4Win Windowed.lnk">>"%tempDir%\CreateShortcut4.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile)>>"%tempDir%\CreateShortcut4.vbs"
echo oLink.TargetPath = "%esDir%\Launch ES Mid Size (1280x720).bat">>"%tempDir%\CreateShortcut4.vbs"
echo oLink.WorkingDirectory = "%esDir%">>"%tempDir%\CreateShortcut4.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe">>"%tempDir%\CreateShortcut4.vbs"
echo oLink.Save>>"%tempDir%\CreateShortcut4.vbs"
CSCRIPT "%tempDir%\CreateShortcut4.vbs"
IF EXIST "%tempDir%\CreateShortcut4.vbs" DEL "%tempDir%\CreateShortcut4.vbs"

IF EXIST "%esDir%\emulationstation.exe" GOTO Selection2_ESNewSucceed
GOTO Selection2_ESNewFailed
::==============================================
:Selection2_ESNewFailed
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =                                                  
echo =    Current Builds of ES are Failing  
echo =
echo =    Falling Back to Version 2.8.0          
echo =                                                  
echo ===========================================
echo =
IF EXIST %esDir%\ RMDIR "%esDir%" /S /Q
IF NOT EXIST %esDir%\ MKDIR "%esDir%"


::es-toolkit
MKDIR "%tempDir%\EmulationStation"
%toolsDir%\Wget\wget.exe -q https://github.com/mattrixk/es-toolkit/archive/refs/tags/v1.2.zip -O "%tempDir%\estoolkit.zip"
ping 127.0.0.1 -n 3 >NUL
%toolsDir%\7za\7za.exe x "%tempDir%\estoolkit.zip" -o"%tempDir%\EmulationStation" >NUL
::delete unneeded portion of downloaded file
DEL "%tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\README.md"
RMDIR "%tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\.emulationstation" /S /Q
::moves batch file scripts to RP4Win\EmulationStation
move %tempDir%\EmulationStation\es-toolkit-1.2\emulationstation\* %esDir%

%toolsDir%\Wget\wget.exe -q https://sourceforge.net/projects/pinn-ironmine86/files/ES_2.8.0/EmulationStation.zip -O "%tempDir%\ES.zip"
ping 127.0.0.1 -n 3 >NUL
::Extracts to the RP4Win\EmulationStation directory
%toolsDir%\7za\7za.exe x "%tempDir%\ES.zip" -o"%esDir%" >NUL

CLS
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
::Cleans up downloaded zip
IF EXIST "%tempDir%\ES.zip" DEL "%tempDir%\ES.zip"
IF EXIST "%tempDir%\estoolkit.zip" DEL "%tempDir%\estoolkit.zip"
IF EXIST %tempDir%\EmulationStation\ RMDIR "%tempDir%\EmulationStation" /S /Q
echo =
echo =
echo =
echo =
echo ============================================
echo =    Creating shortcut icons on Desktop    
echo ============================================
::Deletes old shortcut
IF EXIST "%USERPROFILE%\Desktop\RP4Win.lnk" DEL "%USERPROFILE%\Desktop\RP4Win.lnk"
IF EXIST "%USERPROFILE%\Desktop\RP4Win Windowed.lnk" DEL "%USERPROFILE%\Desktop\RP4Win Windowed.lnk"
IF EXIST "%rp4winDir%\RP4Win.lnk" DEL "%rp4winDir%\RP4Win.lnk"
IF EXIST "%rp4winDir%\RP4Win Windowed.lnk" DEL "%rp4winDir%\RP4Win Windowed.lnk"

::Makes a shortcut on the desktop to Emulationstation called RP4Win (EmulationStation icon)
echo Set oWS = WScript.CreateObject("WScript.Shell")>"%tempDir%\CreateShortcut.vbs"
echo sLinkFile = "%USERPROFILE%\Desktop\RP4Win.lnk">>"%tempDir%\CreateShortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile)>>"%tempDir%\CreateShortcut.vbs"
echo oLink.TargetPath = "%esDir%\Launch ES Fullscreen.bat">>"%tempDir%\CreateShortcut.vbs"
echo oLink.WorkingDirectory = "%esDir%">>"%tempDir%\CreateShortcut.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe">>"%tempDir%\CreateShortcut.vbs"
echo oLink.Save>>"%tempDir%\CreateShortcut.vbs"
CSCRIPT "%tempDir%\CreateShortcut.vbs"
IF EXIST "%tempDir%\CreateShortcut.vbs" DEL "%tempDir%\CreateShortcut.vbs"

IF EXIST "%esDir%\emulationstation.exe" GOTO Selection2_ESNewSucceed
GOTO Selection2_ESInstallTotalFailure
::==============================================
:Selection2_ESInstallTotalFailure
CLS
COLOR FC
echo =
echo =
echo =
echo =
echo ===========================================
echo -------------------------------------------
echo Unable to install any version of Emulation-
echo station. Please create an issue on github
echo with your OS, 64/32 bit, and script 
echo version.                         
echo -------------------------------------------
echo ===========================================
echo      Press any key to return to main menu
PAUSE >NUL
GOTO Main
::==============================================
:Selection2_ESNewSucceed
::Backs up entire themes folder to RP4Win's Temp folder
CLS
echo =
echo =
echo =
echo =
echo ====================================================================
echo =                                                                  
echo =    Backing up  ES Themes  folder                                 
echo =                                                                  
echo =    If this folder does not exist, it will be skipped             
echo =                                                                  
echo =    please wait...                             
echo =
::For now, this just makes a zipped backup of the folder to another location, if it exists.
%toolsDir%\7za\7za.exe a "%rp4winDir%\Backup\Backup_ES-Themes_%FormDate%_%FormTime%.zip" "%themesDir%"

::Installs default Carbon theme
IF NOT EXIST %themesDir%\ MKDIR "%themesDir%"
CD /D "%themesDir%"
IF EXIST carbon\ RMDIR "carbon" /S /Q
IF EXIST CosmicRise\ RMDIR "CosmicRise" /S /Q
IF EXIST Slick_CityLights\ RMDIR "Slick_CityLights" /S /Q

%toolsDir%\git\bin\git.exe clone --recursive https://github.com/RetroPie/es-theme-carbon.git carbon
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/RetroHursty69/es-theme-CosmicRise.git CosmicRise
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/RetroHursty69/es-theme-Slick_CityLights Slick_CityLights



::Installs batocera themes
IF NOT EXIST %toolsDir%\ES-Batocera-Version\.emulationstation\ MKDIR "%toolsDir%\ES-Batocera-Version\.emulationstation"
IF NOT EXIST %toolsDir%\ES-Batocera-Version\.emulationstation\themes\ MKDIR "%toolsDir%\ES-Batocera-Version\.emulationstation\themes"
CD /D "%toolsDir%\ES-Batocera-Version\.emulationstation\themes"
IF EXIST Carbon-Batocera\ RMDIR "Carbon-Batocera" /S /Q
IF EXIST Mru5\ RMDIR "Mru5" /S /Q

%toolsDir%\git\bin\git.exe clone --recursive https://github.com/fabricecaruso/es-theme-carbon.git Carbon-Batocera
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/kelvinator3300/es-theme-mru5.git Mru5

::Fixes missing art (background, logos, etc.) for some systems
COPY %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\background\gc.jpg %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\background\gamecube.jpg
COPY %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\logos\gc-w.svg %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\logos\gamecube.svg
COPY %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\logos\us\pce-cd.svg %toolsDir%\ES-Batocera-Version\.emulationstation\themes\Carbon-Batocera\art\logos\us\pcenginecd.svg

::Checks for temporary files created during automated installer selection
IF EXIST "%tempDir%\BrandNewDef" GOTO Selection2_defaultESCFG
IF EXIST "%tempDir%\BrandNewBlank" GOTO Selection2_blankESCFG
IF EXIST "%tempDir%\BrandNewCus" GOTO Selection2_customESCFG
GOTO completed
::==============================================
::==============================================
:Selection2_ManESCFG
::Menu to manage es_systems.cfg
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    MANAGE ES_SYSTEMS.CFG
echo ===========================================
echo =
echo =    1.) CREATE NEW es_systems.cfg WITH DEFAULT ROM PATH
echo =    %romsDir%\SYSTEM
echo =    (existing file backed-up to %rp4winDir%\Backup\)
echo =
echo -------------------------------------------
echo =
echo =    2.) CREATE NEW es_systems.cfg WITH CUSTOM ROM PATH
echo =    (existing file backed-up to %rp4winDir%\Backup\)
echo =
echo -------------------------------------------
echo =
echo =    3.) CREATE NEW es_systems.cfg WITHOUT ROM PATHS
echo =    (existing file backed-up to %rp4winDir%\Backup\)
echo =
echo -------------------------------------------
echo =
echo =    4.) EDIT es_systems.cfg
echo =
echo -------------------------------------------
echo =
echo =    5.) RETURN TO EMULATIONSTATION MANAGER
echo =
echo ===========================================
echo =
CHOICE /C:12345 /N /T 30 /D 5 /M "=->  Enter selection (1,2,3,4,5): "
IF ERRORLEVEL ==5 GOTO Selection2
IF ERRORLEVEL ==4 GOTO Selection2_editES
IF ERRORLEVEL ==3 GOTO Selection2_blankESCFG
IF ERRORLEVEL ==2 GOTO Selection2_customESCFG
IF ERRORLEVEL ==1 GOTO Selection2_defaultESCFG
GOTO crash
::==============================================
::==============================================
:Selection2_defaultESCFG
::Creates an es_systems.cfg using the default ROM directory C:\RP4Win\EmulationStation\.emulationstation\roms

::Backs up current es_systems.cfg
%toolsDir%\7za\7za.exe a "%rp4winDir%\Backup\Backup_es_systems-config_%FormDate%_%FormTime%.zip" "%esDir%\.emulationstation\es_systems.cfg"

::Deletes old es_systems.cfg
IF EXIST "%esDir%\.emulationstation\es_systems.cfg" DEL "%esDir%\.emulationstation\es_systems.cfg"
IF NOT EXIST %esDir%\.emulationstation\ MKDIR "%esDir%\.emulationstation"

::Creates a new es_systems.cfg
CLS
echo ^<?xml version="1.0"?^> > "%esDir%\.emulationstation\es_systems.cfg"

echo ^<systemList^> >> "%esDir%\.emulationstation\es_systems.cfg"

::::::::::::::::::::::::::::::::::::::::::
:::                                    :::
:::   Arcade                           :::
:::                                    :::
::::::::::::::::::::::::::::::::::::::::::
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
echo     ^<name^>fba^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Final Burn Alpha^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\fba^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fba^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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



::::::::::::::::::::::::::::::::::::::::::
:::                                    :::
:::   Computer                         :::
:::                                    :::
::::::::::::::::::::::::::::::::::::::::::
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
echo     ^<name^>atari800^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 800^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\atari800^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bas .bin .car .com .xex .atr .xfd .dcm .atr.gz .xfd.gz .BAS .BIN .CAR .COM .XEX .ATR .XFD .DCM .ATR.GZ .XFD.GZ^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari800^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari800^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>dragon32^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Dragon 32^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\dragon32^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dragon32^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dragon32^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>zxspectrum^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ZX Spectrum^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\zxspectrum^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sh .sna .szx .z80 .tap .tzx .gz .udi .mgt .img .trd .scl .dsk .zip .7Z .SH .SNA .SZX .Z80 .TAP .TZX .GZ .UDI .MGT .IMG .TRD .SCL .DSK .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fuse_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>zxspectrum^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>zxspectrum^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"



::::::::::::::::::::::::::::::::::::::::::
:::                                    :::
:::   Console                          :::
:::                                    :::
::::::::::::::::::::::::::::::::::::::::::

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
echo     ^<name^>atari2600^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 2600^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\atari2600^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a26 .bin .rom .zip .gz .7Z .A26 .BIN .ROM .ZIP .GZ^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\stella_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari2600^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari2600^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>coleco^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ColecoVision^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\colecovision^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bin .col .rom .zip .BIN .COL .ROM .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>colecovision^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>colecovision^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>fds^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Famicom Disk System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\fds^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .fds .zip .NES .FDS .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>fds^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fds^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>intellivision^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Intellivision^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\intellivision^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.int .bin .INT .BIN^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\jzIntv\bin\jzIntv.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>intellivision^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>intellivision^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>n64^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo 64^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\n64^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.z64 .n64 .v64 .Z64 .N64 .V64^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mupen64plus_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>n64^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>n64^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>nes^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo Entertainment System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\nes^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .NES^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nes^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nes^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>sega32x^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega 32X^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\sega32x^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .32x .smd .bin .md .zip .7Z .32X .SMD .BIN .MD .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\picodrive_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sega32x^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sega32x^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>pcengine^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PC Engine^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\pcengine^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .pce .ccd .cue .zip .7Z .PCE .CCD .CUE .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_pce_fast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>pcengine^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>pcengine^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>psx^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\psx^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\pcsx_rearmed_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psx^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psx^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>snes^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Super Nintendo^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\snes^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .bin .smc .sfc .fig .swc .mgd .zip .7Z .BIN .SMC .SFC .FIG .SWC .MGD .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\snes9x2010_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>snes^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>snes^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

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

::::::::::::::::::::::::::::::::::::::::::
:::                                    :::
:::   Game Engine                      :::
:::                                    :::
::::::::::::::::::::::::::::::::::::::::::




















::::::::::::::::::::::::::::::::::::::::::
:::                                    :::
:::   Portable                         :::
:::                                    :::
::::::::::::::::::::::::::::::::::::::::::
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
echo     ^<name^>gameandwatch^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game & Watch^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\gameandwatch^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.mgw .MGW^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gw_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gameandwatch^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gameandwatch^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>gb^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\gb^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gb .zip .7Z .GB .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gb^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gb^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>gbc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Color^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\gbc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gbc .zip .7Z .GBC .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gbc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gbc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>psp^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation Portable^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\psp^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cso .iso .pbp .CSO .ISO .PBP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ppsspp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psp^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psp^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
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
echo     ^<name^>virtualboy^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Virtualboy^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\virtualboy^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vb .zip .7Z .VB .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>virtualboy^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>virtualboy^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"




::::::::::::::::::::::::::::::::::::::::::
:::                                    :::
:::   Specialty                          :::
:::                                    :::
::::::::::::::::::::::::::::::::::::::::::

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ags^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Adventure Game Studio^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%romsDir%\ags^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.exe .EXE^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ags_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ags^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ags^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo ^</systemList^> >> "%esDir%\.emulationstation\es_systems.cfg"

IF EXIST "%tempDir%\BrandNewDef" GOTO Selection5_DefaultRomFolders
GOTO completed
::==============================================
::==============================================
:Selection2_customESCFG
::Creates es_systems.cfg using the custom ROM directory specified during automated installation or when managing ROM directories.

::Backs up current es_systems.cfg
%toolsDir%\7za\7za.exe a "%rp4winDir%\Backup\Backup_es_systems-config_%FormDate%_%FormTime%.zip" "%esDir%\.emulationstation\es_systems.cfg"

::Deletes old es_systems.cfg
DEL "%esDir%\.emulationstation\es_systems.cfg"
CLS
COLOR 07
echo =
echo =    Enter the path you wish to use for ROMS.
echo = 
echo =    Examples: D:\ROMS, E:\Game\roms, F:\.emulationstation\roms
echo = 
echo =    Press enter when finished. and please double check the path.
echo =    (default %romsDir%)
echo =    (custom %cusromdir%)
::Sets Custom ROM Directory via user input
SET /P cusromdir="=->  Enter Path for ROM Folder: "
IF /I "%cusromdir%" EQU "Q" GOTO Quit
::Creates a new es_systems.cfg
MKDIR "%esDir%\.emulationstation"
echo ^<?xml version="1.0"?^> > "%esDir%\.emulationstation\es_systems.cfg"
echo ^<systemList^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>nes^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo Entertainment System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\nes^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .NES^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nes^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nes^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>fds^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Famicom Disk System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\fds^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .fds .zip .NES .FDS .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>fds^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fds^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>snes^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Super Nintendo^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\snes^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .bin .smc .sfc .fig .swc .mgd .zip .7Z .BIN .SMC .SFC .FIG .SWC .MGD .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\snes9x2010_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>snes^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>snes^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>n64^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo 64^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\n64^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.z64 .n64 .v64 .Z64 .N64 .V64^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mupen64plus_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>n64^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>n64^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<name^>gc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Gamecube^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<path^>%cusromdir%\gc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.iso .gcz .gcn .ISO .GCZ .GCN^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Dolphin\DolphinWx.exe --exec="%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<platform^>gc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<theme^>gc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<name^>wii^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Wii^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<path^>%cusromdir%\wii^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.iso .ISO^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Dolphin\DolphinWx.exe --exec="%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<platform^>wii^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<theme^>wii^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<name^>wiiu^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Wiiu^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<path^>%cusromdir%\wiiu^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.rpx .RPX .iso .ISO .wud .WUD .wux .WUX^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Cemu\Cemu.exe -f -g "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<platform^>wiiu^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<theme^>wiiu^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gameandwatch^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game & Watch^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\gameandwatch^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.mgw .MGW^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gw_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gameandwatch^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gameandwatch^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gb^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\gb^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gb .zip .7Z .GB .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gb^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gb^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>virtualboy^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Virtualboy^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\virtualboy^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vb .zip .7Z .VB .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>virtualboy^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>virtualboy^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gbc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Color^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\gbc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gbc .zip .7Z .GBC .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gbc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gbc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gba^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Advance^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\gba^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gba .zip .7Z .GBA .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gpsp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gba^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gba^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>nds^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo DS^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\nds^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.zip .ZIP .nds .NDS^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\melonds_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nds^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nds^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>sg-1000^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega SG-1000^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\sg-1000^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.sg .bin .zip .SG .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sg-1000^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sg-1000^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>mastersystem^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Master System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\mastersystem^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sms .bin .zip .7Z .SMS .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>mastersystem^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>mastersystem^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>megadrive^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Mega Drive^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\megadrive^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .smd .bin .gen .md .sg .zip .7Z .SMD .BIN .GEN .MD .SG .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>megadrive^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>megadrive^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>segacd^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Mega CD^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\segacd^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.iso .cue .ISO .CUE^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>segacd^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>segacd^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>sega32x^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega 32X^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\sega32x^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .32x .smd .bin .md .zip .7Z .32X .SMD .BIN .MD .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\picodrive_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sega32x^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sega32x^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>saturn^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Saturn^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\saturn^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .CUE .ccd .CCD .chd .CHD .toc .TOC .m3u .M3U^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_saturn_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>saturn^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>saturn^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>dreamcast^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Dreamcast^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\dreamcast^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.gdi .cdi .GDI .CDI .chd .CHD^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\reicast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dreamcast^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dreamcast^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gamegear^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Gamegear^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\gamegear^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gg .bin .sms .zip .7Z .GG .BIN .SMS .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gamegear^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gamegear^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>psx^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\psx^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\pcsx_rearmed_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psx^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psx^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ps2^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation 2^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\ps2^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\PCSX2\pcsx2.exe "%%ROM_RAW%%" --fullscreen^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ps2^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ps2^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>psp^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation Portable^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\psp^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cso .iso .pbp .CSO .ISO .PBP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ppsspp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psp^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psp^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari2600^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 2600^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atari2600^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a26 .bin .rom .zip .gz .7Z .A26 .BIN .ROM .ZIP .GZ^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\stella_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari2600^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari2600^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari800^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 800^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atari800^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bas .bin .car .com .xex .atr .xfd .dcm .atr.gz .xfd.gz .BAS .BIN .CAR .COM .XEX .ATR .XFD .DCM .ATR.GZ .XFD.GZ^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari800^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari800^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari5200^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 5200^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atari5200^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.a52 .bin .car .A52 .BIN .CAR^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari5200^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari5200^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari7800^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 7800 ProSystem^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atari7800^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a78 .bin .zip .7Z .A78 .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\prosystem_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari7800^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari7800^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarijaguar^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari Jaguar^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atarijaguar^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.j64 .jag .zip .J64 .JAG .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\virtualjaguar_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarijaguar^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarijaguar^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarilynx^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari Lynx^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atarilynx^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .lnx .zip .7Z .LNX .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\handy_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarilynx^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarilynx^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarist^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari ST^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atarist^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.st .stx .img .rom .raw .ipf .ctr .ST .STX .IMG .ROM .RAW .IPF .CTR^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\Hatari\Hatari.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarist^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarist^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>neogeo^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\neogeo^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>neogeo^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>neogeo^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>fba^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Final Burn Alpha^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\fba^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fba^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ngp^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo Pocket^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\ngp^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ngp .zip .NGP .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_ngp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ngp^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ngp^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ngpc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo Pocket Color^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\ngpc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ngc .zip .NGC .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_ngp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ngpc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ngpc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>mame-libretro^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Multiple Arcade Machine Emulator^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\mame^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.zip .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mame2003_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>mame^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>3do^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>3DO^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\3do^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.iso .ISO^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\4do_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>3do^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>3do^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ags^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Adventure Game Studio^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\ags^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.exe .EXE^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ags_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ags^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ags^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>amiga^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Amiga^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\amiga^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.adf .ADF .zip .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\puae_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>amiga^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>amiga^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>amstradcpc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Amstrad CPC^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\amstradcpc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cdt .cpc .dsk .CDT .CPC .DSK^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\cap32_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>amstradcpc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>amstradcpc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>apple2^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Apple II^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\apple2^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.dsk .DSK^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%rp4winDir%\AppleWin\Applewin.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>apple2^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>apple2^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>bbcmicro^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari ST^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\atarist^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ssd .dsd .ad .img .SSD .DSD .AD .IMG^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\BeebEm\BeebEm.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>bbcmicro^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>bbcmicro^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>c64^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Commodore 64^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\c64^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.crt .d64 .g64 .t64 .tap .x64 .zip .prg .CRT .D64 .G64 .T64 .TAP .X64 .ZIP .PRG^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\WinVICE\x64.exe -fullscreen "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>c64^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>c64^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>coco^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>CoCo^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\coco^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>coco^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>coco^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>coleco^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ColecoVision^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\colecovision^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bin .col .rom .zip .BIN .COL .ROM .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>colecovision^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>colecovision^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>daphne^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Daphne^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\daphne^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.daphne .DAPHNE^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\Daphne\daphne.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>daphne^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>daphne^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>dragon32^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Dragon 32^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\dragon32^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dragon32^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dragon32^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>intellivision^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Intellivision^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\intellivision^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.int .bin .INT .BIN^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\jzIntv\bin\jzIntv.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>intellivision^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>intellivision^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>msx^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>MSX^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\msx^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.rom .mx1 .mx2 .col .dsk .zip .ROM .MX1 .MX2 .COL .DSK .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>msx^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>msx^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>pcengine^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PC Engine^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\pcengine^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .pce .ccd .cue .zip .7Z .PCE .CCD .CUE .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_pce_fast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>pcengine^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>pcengine^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>vectrex^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Vectrex^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\vectrex^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vec .gam .bin .zip .7Z .VEC .GAM .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>vectrex^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>vectrex^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>zxspectrum^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ZX Spectrum^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>%cusromdir%\zxspectrum^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sh .sna .szx .z80 .tap .tzx .gz .udi .mgt .img .trd .scl .dsk .zip .7Z .SH .SNA .SZX .Z80 .TAP .TZX .GZ .UDI .MGT .IMG .TRD .SCL .DSK .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fuse_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>zxspectrum^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>zxspectrum^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo ^</systemList^> >> "%esDir%\.emulationstation\es_systems.cfg"
IF EXIST "%tempDir%\BrandNewCus" GOTO Selection5_CustomRomFolders
GOTO completed
::==============================================
::==============================================
:Selection2_blankESCFG
::Creates an es_systems.cfg without ROM directories incase you need/want something special (Not recommended as it's kinda poop to enter all the stuff manually.

::Backs up current es_systems.cfg
%toolsDir%\7za\7za.exe a "%rp4winDir%\Backup\Backup_es_systems-config_%FormDate%_%FormTime%.zip" "%esDir%\.emulationstation\es_systems.cfg"

::Deletes old es_systems.cfg
DEL "%esDir%\.emulationstation\es_systems.cfg"

::Creates a new es_systems.cfg
CLS
MKDIR "%esDir%\.emulationstation"
echo ^<?xml version="1.0"?^> > "%esDir%\.emulationstation\es_systems.cfg"

echo ^<systemList^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>nes^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo Entertainment System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\nes^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .NES^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nes^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nes^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>fds^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Famicom Disk System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\fds^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.nes .fds .zip .NES .FDS .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fceumm_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>fds^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fds^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>snes^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Super Nintendo^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\snes^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .bin .smc .sfc .fig .swc .mgd .zip .7Z .BIN .SMC .SFC .FIG .SWC .MGD .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\snes9x2010_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>snes^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>snes^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>n64^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo 64^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\n64^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.z64 .n64 .v64 .Z64 .N64 .V64^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mupen64plus_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>n64^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>n64^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<name^>gc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Gamecube^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<path^>C:\PATH\TO\ROM\FOLDER\gc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.iso .gcz .gcn .ISO .GCZ .GCN^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Dolphin\DolphinWx.exe --exec="%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<platform^>gc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<theme^>gc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<name^>wii^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Wii^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<path^>C:\PATH\TO\ROM\FOLDER\wii^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.iso .ISO^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Dolphin\DolphinWx.exe --exec="%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<platform^>wii^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<theme^>wii^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<name^>wiiu^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<fullname^>Nintendo Wiiu^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<path^>C:\PATH\TO\ROM\FOLDER\wiiu^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<extension^>.rpx .RPX .iso .ISO .wud .WUD .wux .WUX^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<command^>%systemsDir%\Cemu\Cemu.exe -f -g "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<platform^>wiiu^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo 	^<theme^>wiiu^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo    ^</system^>  >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gameandwatch^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game & Watch^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\gameandwatch^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.mgw .MGW^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gw_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gameandwatch^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gameandwatch^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gb^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\gb^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gb .zip .7Z .GB .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gb^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gb^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>virtualboy^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Virtualboy^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\virtualboy^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vb .zip .7Z .VB .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>virtualboy^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>virtualboy^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gbc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Color^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\gbc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gbc .zip .7Z .GBC .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gambatte_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gbc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gbc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gba^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Game Boy Advance^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\gba^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gba .zip .7Z .GBA .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\gpsp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gba^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gba^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>nds^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Nintendo DS^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\nds^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.zip .ZIP .nds .NDS^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\melonds_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>nds^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>nds^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>sg-1000^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega SG-1000^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\sg-1000^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.sg .bin .zip .SG .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sg-1000^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sg-1000^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>mastersystem^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Master System^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\mastersystem^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sms .bin .zip .7Z .SMS .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>mastersystem^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>mastersystem^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>megadrive^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Mega Drive^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\megadrive^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .smd .bin .gen .md .sg .zip .7Z .SMD .BIN .GEN .MD .SG .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>megadrive^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>megadrive^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>segacd^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Mega CD^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\segacd^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.iso .cue .ISO .CUE^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>segacd^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>segacd^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>sega32x^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega 32X^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\sega32x^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .32x .smd .bin .md .zip .7Z .32X .SMD .BIN .MD .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\picodrive_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>sega32x^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>sega32x^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>saturn^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Saturn^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\saturn^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .CUE .m3u .M3U .toc .TOC .CCD .ccd .^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_saturn_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>saturn^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>saturn^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>dreamcast^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Dreamcast^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\dreamcast^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.gdi .cdi .GDI .CDI .chd .CHD^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\reicast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dreamcast^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dreamcast^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>gamegear^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Sega Gamegear^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\gamegear^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .gg .bin .sms .zip .7Z .GG .BIN .SMS .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\genesis_plus_gx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>gamegear^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>gamegear^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>psx^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\psx^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\pcsx_rearmed_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psx^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psx^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ps2^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation 2^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\ps2^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cue .cbn .gz .img .iso .m3u .mdf .pbp .toc .z .znx .GZ .CUE .CBN .IMG .ISO .M3U .MDF .PBP .TOC .Z .ZNX^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\PCSX2\pcsx2.exe "%%ROM_RAW%%" --fullscreen^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ps2^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ps2^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>psp^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PlayStation Portable^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\psp^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cso .iso .pbp .CSO .ISO .PBP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ppsspp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>psp^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>psp^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari2600^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 2600^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atari2600^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a26 .bin .rom .zip .gz .7Z .A26 .BIN .ROM .ZIP .GZ^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\stella_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari2600^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari2600^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari800^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 800^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atari800^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bas .bin .car .com .xex .atr .xfd .dcm .atr.gz .xfd.gz .BAS .BIN .CAR .COM .XEX .ATR .XFD .DCM .ATR.GZ .XFD.GZ^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari800^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari800^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari5200^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 5200^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atari5200^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.a52 .bin .car .A52 .BIN .CAR^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\atari800_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari5200^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari5200^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atari7800^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari 7800 ProSystem^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atari7800^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .a78 .bin .zip .7Z .A78 .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\prosystem_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atari7800^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atari7800^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarijaguar^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari Jaguar^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atarijaguar^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.j64 .jag .zip .J64 .JAG .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\virtualjaguar_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarijaguar^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarijaguar^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarilynx^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari Lynx^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atarilynx^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .lnx .zip .7Z .LNX .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\handy_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarilynx^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarilynx^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>atarist^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari ST^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atarist^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.st .stx .img .rom .raw .ipf .ctr .ST .STX .IMG .ROM .RAW .IPF .CTR^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\Hatari\Hatari.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>atarist^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>atarist^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>neogeo^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\neogeo^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>neogeo^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>neogeo^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>fba^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Final Burn Alpha^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\fba^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.fba .zip .FBA .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fbalpha_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>fba^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ngp^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo Pocket^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\ngp^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ngp .zip .NGP .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_ngp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ngp^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ngp^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ngpc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Neo Geo Pocket Color^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\ngpc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ngc .zip .NGC .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_ngp_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ngpc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ngpc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>mame-libretro^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Multiple Arcade Machine Emulator^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\mame^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.zip .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mame2003_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>arcade^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>mame^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>3do^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>3DO^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\3do^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.iso .ISO^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\4do_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>3do^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>3do^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>ags^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Adventure Game Studio^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\ags^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.exe .EXE^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\ags_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>ags^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>ags^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>amiga^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Amiga^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\amiga^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.adf .ADF .zip .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\puae_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>amiga^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>amiga^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>amstradcpc^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Amstrad CPC^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\amstradcpc^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cdt .cpc .dsk .CDT .CPC .DSK^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\cap32_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>amstradcpc^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>amstradcpc^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>apple2^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Apple II^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\apple2^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.dsk .DSK^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%rp4winDir%\AppleWin\Applewin.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>apple2^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>apple2^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>bbcmicro^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Atari ST^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\atarist^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.ssd .dsd .ad .img .SSD .DSD .AD .IMG^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\BeebEm\BeebEm.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>bbcmicro^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>bbcmicro^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>c64^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Commodore 64^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\c64^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.crt .d64 .g64 .t64 .tap .x64 .zip .prg .CRT .D64 .G64 .T64 .TAP .X64 .ZIP .PRG^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\WinVICE\x64.exe -fullscreen "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>c64^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>c64^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>coco^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>CoCo^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\coco^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>coco^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>coco^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>coleco^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ColecoVision^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\colecovision^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.bin .col .rom .zip .BIN .COL .ROM .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>colecovision^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>colecovision^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>daphne^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Daphne^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\daphne^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.daphne .DAPHNE^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\Daphne\daphne.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>daphne^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>daphne^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>dragon32^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Dragon 32^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\dragon32^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.cas .wav .bas .asc .dmk .jvc .os9 .dsk .vdk .rom .ccc .sna .CAS .WAV .BAS .ASC .DMK .JVC .OS9 .DSK .VDK .ROM .CCC .SNA^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\XRoar\xroar.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>dragon32^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>dragon32^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>intellivision^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Intellivision^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\intellivision^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.int .bin .INT .BIN^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%systemsDir%\jzIntv\bin\jzIntv.exe "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>intellivision^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>intellivision^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>msx^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>MSX^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\msx^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.rom .mx1 .mx2 .col .dsk .zip .ROM .MX1 .MX2 .COL .DSK .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\bluemsx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>msx^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>msx^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>pcengine^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>PC Engine^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\pcengine^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .pce .ccd .cue .zip .7Z .PCE .CCD .CUE .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\mednafen_pce_fast_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>pcengine^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>pcengine^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>vectrex^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>Vectrex^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\vectrex^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .vec .gam .bin .zip .7Z .VEC .GAM .BIN .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\vecx_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>vectrex^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>vectrex^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo   ^<system^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<name^>zxspectrum^</name^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<fullname^>ZX Spectrum^</fullname^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<path^>C:\PATH\TO\ROM\FOLDER\zxspectrum^</path^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<extension^>.7z .sh .sna .szx .z80 .tap .tzx .gz .udi .mgt .img .trd .scl .dsk .zip .7Z .SH .SNA .SZX .Z80 .TAP .TZX .GZ .UDI .MGT .IMG .TRD .SCL .DSK .ZIP^</extension^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<command^>%RADir%\retroarch.exe -L %RADir%\cores\fuse_libretro.dll "%%ROM_RAW%%"^</command^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<platform^>zxspectrum^</platform^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo     ^<theme^>zxspectrum^</theme^> >> "%esDir%\.emulationstation\es_systems.cfg"
echo   ^</system^> >> "%esDir%\.emulationstation\es_systems.cfg"

echo ^</systemList^> >> "%esDir%\.emulationstation\es_systems.cfg"
IF EXIST "%tempDir%\BrandNewBlank" GOTO Selection3_updateRA
GOTO completed
::==============================================
::==============================================
:Selection2_editES
CLS
notepad %esDir%\.emulationstation\es_systems.cfg
GOTO Selection2_ManESCFG
::==============================================
::==============================================
:Selection2_ThemeManager
::Menu for managing and installing themes for EmulationStation
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Theme Manager                 
echo ===========================================
echo =
echo =    1.) INSTALL/UPDATE ALL ES THEMES
echo =
echo =    2.) INSTALL/UPDATE INDIVIDUAL THEMES
echo =
echo -------------------------------------------
echo =
echo =    3.) THEME GALLERY/PREVIEWS
echo =
echo -------------------------------------------
echo =
echo =    4.) EXIT THEME MANAGER
echo =
echo ===========================================
echo =
CHOICE /C 1234 /N /T 30 /D 4 /M "=->  Enter selection (1,2,3,4): "
IF ERRORLEVEL ==4 GOTO Selection2
IF ERRORLEVEL ==3 GOTO Selection2_ThemeGallerySetupCheck
IF ERRORLEVEL ==2 GOTO Selection2_IndThemes
IF ERRORLEVEL ==1 GOTO Selection2_AllThemes
GOTO crash
::==============================================
:Selection2_ThemeGallerySetupCheck
::Checks if the Theme Gallery is already setup. if not goes to the setup.
IF EXIST "%esDir%\.emulationstation\es-theme-gallery\carbon.png" GOTO Selection2_ThemeGallery
GOTO Selection2_ThemeGallerySetup
::==============================================
:Selection2_ThemeGallerySetup
::Clones the "theme gallery" into the emulationstation settings folder
CD /D "%esDir%\.emulationstation"
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/wetriner/es-theme-gallery.git
GOTO Selection2_ThemeGallery
::==============================================
:Selection2_ThemeGallery
::Creates a basic HTML file with the images in the theme gallery. Prompts the user on how to interact. Once closed deletes the html file.
CD /D "%esDir%\.emulationstation\es-theme-gallery"
FOR %%i IN (*.png) DO ECHO ^<img src="%%i" title="%%~ni" height="400" width="600" /^>>>Gallery.html
START Gallery.html
CLS
echo =
echo =
echo =
echo =
echo ===========================================================================
echo =                                                                         
echo =    HOVER OVER ANY IMAGE TO SEE WHICH THEME IT BELONGS TO.
echo =
echo =    PRESS ANY KEY WHEN DONE BROWSING THE GALLERY.                 
echo =                                                                         
echo ===========================================================================
PAUSE >NUL
DEL Gallery.html
GOTO Selection2_ThemeManager
::==============================================
::==============================================
:Selection2_IndThemes
::Menus for installing individual themes for EmulationStation.
:IndThemes_page1
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Install/Update Individual Themes                 
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
echo *    9.)                                  *
echo *-----------------------------------------*
echo *    N.) NEXT PAGE                        *
echo *    P.) PREVIOUS PAGE                    *
echo ===========================================
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==11 GOTO IndThemes_page10
IF ERRORLEVEL ==10 GOTO IndThemes_page2
IF ERRORLEVEL ==9 GOTO 
IF ERRORLEVEL ==8 GOTO nbba 
IF ERRORLEVEL ==7 GOTO color-pi 
IF ERRORLEVEL ==6 GOTO clean-look 
IF ERRORLEVEL ==5 GOTO simple-dark 
IF ERRORLEVEL ==4 GOTO simple 
IF ERRORLEVEL ==3 GOTO carbon-nometa 
IF ERRORLEVEL ==2 GOTO carbon-centered 
IF ERRORLEVEL ==1 GOTO carbon 
GOTO crash
::==============================================
:IndThemes_page2
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Install/Update Individual Themes                 
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
echo *    9.)                                  *
echo *-----------------------------------------*
echo *    N.) NEXT PAGE                        *
echo *    P.) PREVIOUS PAGE                    *
echo ===========================================
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==11 GOTO IndThemes_page1
IF ERRORLEVEL ==10 GOTO IndThemes_page3
IF ERRORLEVEL ==9 GOTO 
IF ERRORLEVEL ==8 GOTO minilumi
IF ERRORLEVEL ==7 GOTO luminous
IF ERRORLEVEL ==6 GOTO pixel-tft
IF ERRORLEVEL ==5 GOTO pixel-metadata
IF ERRORLEVEL ==4 GOTO pixel
IF ERRORLEVEL ==3 GOTO zoid
IF ERRORLEVEL ==2 GOTO turtle-pi 
IF ERRORLEVEL ==1 GOTO simplified-static-canela
GOTO crash
::==============================================
:IndThemes_page3
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Install/Update Individual Themes                 
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
echo *    9.)                                  *
echo *-----------------------------------------*
echo *    N.) NEXT PAGE                        *
echo *    P.) PREVIOUS PAGE                    *
echo ===========================================
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==11 GOTO IndThemes_page2
IF ERRORLEVEL ==10 GOTO IndThemes_page4
IF ERRORLEVEL ==9 GOTO 
IF ERRORLEVEL ==8 GOTO simpler-turtlepi
IF ERRORLEVEL ==7 GOTO retroplay-clean-detail-canela
IF ERRORLEVEL ==6 GOTO retroplay-clean-canela
IF ERRORLEVEL ==5 GOTO page3
IF ERRORLEVEL ==4 GOTO eudora-concise
IF ERRORLEVEL ==3 GOTO eudora-bigshot
IF ERRORLEVEL ==2 GOTO eudora
IF ERRORLEVEL ==1 GOTO workbench
GOTO crash
::==============================================
:IndThemes_page4
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Install/Update Individual Themes                 
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
echo *    9.)                                  *
echo *-----------------------------------------*
echo *    N.) NEXT PAGE                        *
echo *    P.) PREVIOUS PAGE                    *
echo ===========================================
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==11 GOTO IndThemes_page3
IF ERRORLEVEL ==10 GOTO IndThemes_page5
IF ERRORLEVEL ==9 GOTO 
IF ERRORLEVEL ==8 GOTO simplebigart
IF ERRORLEVEL ==7 GOTO space
IF ERRORLEVEL ==6 GOTO spare
IF ERRORLEVEL ==5 GOTO metapixel
IF ERRORLEVEL ==4 GOTO io
IF ERRORLEVEL ==3 GOTO material
IF ERRORLEVEL ==2 GOTO metro
IF ERRORLEVEL ==1 GOTO simpler-turtlemini
GOTO crash
::==============================================
:IndThemes_page5
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Install/Update Individual Themes                 
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
echo *    9.)                                  *
echo *-----------------------------------------*
echo *    N.) NEXT PAGE                        *
echo *    P.) PREVIOUS PAGE                    *
echo ===========================================
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==11 GOTO IndThemes_page4
IF ERRORLEVEL ==10 GOTO IndThemes_page6
IF ERRORLEVEL ==9 GOTO 
IF ERRORLEVEL ==8 GOTO futura-V
IF ERRORLEVEL ==7 GOTO switch-dark
IF ERRORLEVEL ==6 GOTO switch-light
IF ERRORLEVEL ==5 GOTO minimal
IF ERRORLEVEL ==4 GOTO flat-dark
IF ERRORLEVEL ==3 GOTO flat
IF ERRORLEVEL ==2 GOTO tronkyfran
IF ERRORLEVEL ==1 GOTO tv
GOTO crash
::==============================================
:IndThemes_page6
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Install/Update Individual Themes                 
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
echo *    9.)                                  *
echo *-----------------------------------------*
echo *    N.) NEXT PAGE                        *
echo *    P.) PREVIOUS PAGE                    *
echo ===========================================
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==11 GOTO IndThemes_page5
IF ERRORLEVEL ==10 GOTO IndThemes_page7
IF ERRORLEVEL ==9 GOTO 
IF ERRORLEVEL ==8 GOTO art-book
IF ERRORLEVEL ==7 GOTO crt-centered
IF ERRORLEVEL ==6 GOTO crt
IF ERRORLEVEL ==5 GOTO snesminiind
IF ERRORLEVEL ==4 GOTO famicom-mini
IF ERRORLEVEL ==3 GOTO nes-mini
IF ERRORLEVEL ==2 GOTO fundamental
IF ERRORLEVEL ==1 GOTO futura-dark-V
GOTO crash
::==============================================
:IndThemes_page7
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Install/Update Individual Themes                 
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
echo *    9.)                                  *
echo *-----------------------------------------*
echo *    N.) NEXT PAGE                        *
echo *    P.) PREVIOUS PAGE                    *
echo ===========================================
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==11 GOTO IndThemes_page6
IF ERRORLEVEL ==10 GOTO IndThemes_page8
IF ERRORLEVEL ==9 GOTO 
IF ERRORLEVEL ==8 GOTO cygnus
IF ERRORLEVEL ==7 GOTO ComicBook_4-3_SE-Wheelart
IF ERRORLEVEL ==6 GOTO ComicBook_SE-Wheelart
IF ERRORLEVEL ==5 GOTO ComicBook_4-3
IF ERRORLEVEL ==4 GOTO ComicBook
IF ERRORLEVEL ==3 GOTO tft
IF ERRORLEVEL ==2 GOTO art-book-pocket
IF ERRORLEVEL ==1 GOTO art-book-4-3
GOTO crash
::==============================================
:IndThemes_page8
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Install/Update Individual Themes                 
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
echo *    9.)                                  *
echo *-----------------------------------------*
echo *    N.) NEXT PAGE                        *
echo *    P.) PREVIOUS PAGE                    *
echo ===========================================
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==11 GOTO IndThemes_page7
IF ERRORLEVEL ==10 GOTO IndThemes_page9
IF ERRORLEVEL ==9 GOTO 
IF ERRORLEVEL ==8 GOTO gbz35
IF ERRORLEVEL ==7 GOTO SpaceOddity
IF ERRORLEVEL ==6 GOTO Retrorama
IF ERRORLEVEL ==5 GOTO kidz
IF ERRORLEVEL ==4 GOTO showcase
IF ERRORLEVEL ==3 GOTO maximuspie
IF ERRORLEVEL ==2 GOTO hurstyblue
IF ERRORLEVEL ==1 GOTO steampunk
GOTO crash
::==============================================
:IndThemes_page9
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Install/Update Individual Themes                 
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
echo *    9.)                                  *
echo *-----------------------------------------*
echo *    N.) NEXT PAGE                        *
echo *    P.) PREVIOUS PAGE                    *
echo ===========================================
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==11 GOTO IndThemes_page8
IF ERRORLEVEL ==10 GOTO IndThemes_page10
IF ERRORLEVEL ==9 GOTO 
IF ERRORLEVEL ==8 GOTO superdisplay
IF ERRORLEVEL ==7 GOTO playstation
IF ERRORLEVEL ==6 GOTO stirling
IF ERRORLEVEL ==5 GOTO magazinemadness
IF ERRORLEVEL ==4 GOTO Royal_Primicia
IF ERRORLEVEL ==3 GOTO bigwood
IF ERRORLEVEL ==2 GOTO marioblue
IF ERRORLEVEL ==1 GOTO gbz35-dark
GOTO crash
::==============================================
:IndThemes_page10
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Install/Update Individual Themes                 
echo ===========================================
echo *                Page 10                  *
echo *    1.) SCV720                           *
echo *    2.) MERRYXMAS                        *
echo *    3.) RETROROID                        *
echo *    4.) GREENILICIOUS                    *
echo *    5.) BOXALLOYBLUE                     *
echo *    6.) BOXALLOYRED                      *
echo *    7.) SYNTHWAVE                        *
echo *    8.)                                  *
echo *    9.)                                  *
echo *-----------------------------------------*
echo *    N.) NEXT PAGE                        *
echo *    P.) PREVIOUS PAGE                    *
echo ===========================================
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Selection2_ThemeManager
IF ERRORLEVEL ==11 GOTO IndThemes_page9
IF ERRORLEVEL ==10 GOTO IndThemes_page1
IF ERRORLEVEL ==9 GOTO 
IF ERRORLEVEL ==8 GOTO 
IF ERRORLEVEL ==7 GOTO synthwave
IF ERRORLEVEL ==6 GOTO boxalloyred
IF ERRORLEVEL ==5 GOTO boxalloyblue
IF ERRORLEVEL ==4 GOTO greenilicious
IF ERRORLEVEL ==3 GOTO retroroid
IF ERRORLEVEL ==2 GOTO merryxmas
IF ERRORLEVEL ==1 GOTO scv720
GOTO crash
::==============================================
::Sets a variable for each theme individually. Then moves to cloning from github.
:carbon
SET repo=RetroPie
SET theme=carbon
GOTO insttheme
:carbon-centered
SET repo=RetroPie
SET theme=carbon-centered
GOTO insttheme
:carbon-nometa
SET repo=RetroPie
SET theme=carbon-nometa
GOTO insttheme
:simple
SET repo=RetroPie
SET theme=simple
GOTO insttheme
:simple-dark
SET repo=RetroPie
SET theme=simple-dark
GOTO insttheme
:clean-look
SET repo=RetroPie
SET theme=clean-look
GOTO insttheme
:color-pi
SET repo=RetroPie
SET theme=color-pi
GOTO insttheme
:nbba
SET repo=RetroPie
SET theme=nbba
GOTO insttheme
:simplified-static-canela
SET repo=RetroPie
SET theme=simplified-static-canela
GOTO insttheme
:turtle-pi
SET repo=RetroPie
SET theme=turtle-pi
GOTO insttheme
:zoid
SET repo=RetroPie
SET theme=zoid
GOTO insttheme
:pixel
SET repo=ehettervik
SET theme=pixel
GOTO insttheme
:pixel-metadata
SET repo=ehettervik
SET theme=pixel-metadata
GOTO insttheme
:pixel-tft
SET repo=ehettervik
SET theme=pixel-tft
GOTO insttheme
:luminous
SET repo=ehettervik
SET theme=luminous
GOTO insttheme
:minilumi
SET repo=ehettervik
SET theme=minilumi
GOTO insttheme
:workbench
SET repo=ehettervik
SET theme=workbench
GOTO insttheme
:eudora
SET repo=AmadhiX
SET theme=eudora
GOTO insttheme
:eudora-bigshot
SET repo=AmadhiX
SET theme=eudora-bigshot
GOTO insttheme
:eudora-concise
SET repo=AmadhiX
SET theme=eudora-concise
GOTO insttheme
::eudora-updated
::SET repo=ChoccyHobNob
::SET theme=eudora-updated
::GOTO insttheme
:retroplay-clean-canela
SET repo=InsecureSpike
SET theme=retroplay-clean-canela
GOTO insttheme
:retroplay-clean-detail-canela
SET repo=InsecureSpike
SET theme=retroplay-clean-detail-canela
GOTO insttheme
:simpler-turtlepi
SET repo=Omnija
SET theme=simpler-turtlepi
GOTO insttheme
:simpler-turtlemini
SET repo=Omnija
SET theme=simpler-turtlemini
GOTO insttheme
:metro
SET repo=Omnija
SET theme=metro
GOTO insttheme
:material
SET repo=lilbud
SET theme=material
GOTO insttheme
:io
SET repo=mattrixk
SET theme=io
GOTO insttheme
:metapixel
SET repo=mattrixk
SET theme=metapixel
GOTO insttheme
:spare
SET repo=mattrixk
SET theme=spare
GOTO insttheme
:space
SET repo=robertybob
SET theme=space
GOTO insttheme
:simplebigart
SET repo=robertybob
SET theme=simplebigart
GOTO insttheme
:tv
SET repo=robertybob
SET theme=tv
GOTO insttheme
:tronkyfran
SET repo=HerbFargus
SET theme=tronkyfran
GOTO insttheme
:flat
SET repo=lilbud
SET theme=flat
GOTO insttheme
:flat-dark
SET repo=lilbud
SET theme=flat-dark
GOTO insttheme
:minimal
SET repo=lilbud
SET theme=minimal
GOTO insttheme
:switch-light
SET repo=lilbud
SET theme=switch-light
GOTO insttheme
:switch-dark
SET repo=lilbud
SET theme=switch-dark
GOTO insttheme
:futura-V
SET repo=FlyingTomahawk
SET theme=futura-V
GOTO insttheme
:futura-dark-V
SET repo=FlyingTomahawk
SET theme=futura-dark-V
GOTO insttheme
:fundamental
SET repo=G-rila
SET theme=fundamental
GOTO insttheme
:nes-mini
SET repo=ruckage
SET theme=nes-mini
GOTO insttheme
:famicom-mini
SET repo=ruckage
SET theme=famicom-mini
GOTO insttheme
:snesminiind
SET repo=ruckage
SET theme=snes-mini
GOTO insttheme
:crt
SET repo=anthonycaccese
SET theme=crt
GOTO insttheme
:crt-centered
SET repo=anthonycaccese
SET theme=crt-centered
GOTO insttheme
:art-book
SET repo=anthonycaccese
SET theme=art-book
GOTO insttheme
:art-book-4-3
SET repo=anthonycaccese
SET theme=art-book-4-3
GOTO insttheme
:art-book-pocket
SET repo=anthonycaccese
SET theme=art-book-pocket
GOTO insttheme
:tft
SET repo=anthonycaccese
SET theme=tft
GOTO insttheme
:ComicBook
SET repo=TMNTturtleguy
SET theme=ComicBook
GOTO insttheme
:ComicBook_4-3
SET repo=TMNTturtleguy
SET theme=ComicBook_4-3
GOTO insttheme
:ComicBook_SE-Wheelart
SET repo=TMNTturtleguy
SET theme=ComicBook_SE-Wheelart
GOTO insttheme
:ComicBook_4-3_SE-Wheelart
SET repo=TMNTturtleguy
SET theme=ComicBook_4-3_SE-Wheelart
GOTO insttheme
:cygnus
SET repo=ChoccyHobNob
SET theme=cygnus
GOTO insttheme
:steampunk
SET repo=dmmarti
SET theme=steampunk
GOTO insttheme
:hurstyblue
SET repo=dmmarti
SET theme=hurstyblue
GOTO insttheme
:maximuspie
SET repo=dmmarti
SET theme=maximuspie
GOTO insttheme
:showcase
SET repo=dmmarti
SET theme=showcase
GOTO insttheme
:kidz
SET repo=dmmarti
SET theme=kidz
GOTO insttheme
:Retrorama
SET repo=lipebello
SET theme=Retrorama
GOTO insttheme
:SpaceOddity
SET repo=lipebello
SET theme=SpaceOddity
GOTO insttheme
:gbz35
SET repo=rxbrad
SET theme=gbz35
GOTO insttheme
:gbz35-dark
SET repo=rxbrad
SET theme=gbz35-dark
GOTO insttheme
:marioblue
SET repo=garaine
SET theme=marioblue
GOTO insttheme
:bigwood
SET repo=garaine
SET theme=bigwood
GOTO insttheme
:Royal_Primicia
SET repo=MrTomixf
SET theme=Royal_Primicia
GOTO insttheme
:magazinemadness
SET repo=RetroHursty69
SET theme=magazinemadness
GOTO insttheme
:stirling
SET repo=RetroHursty69
SET theme=stirling
GOTO insttheme
:playstation
SET repo=lostless
SET theme=playstation
GOTO insttheme
:superdisplay
SET repo=mrharias
SET theme=superdisplay
GOTO insttheme
:synthwave
SET repo=coinjunkie
SET theme=synthwave
GOTO insttheme
:boxalloyred
SET repo=RetroHursty69
SET theme=boxalloyred
GOTO insttheme
:boxalloyblue
SET repo=RetroHursty69
SET theme=boxalloyblue
GOTO insttheme
:greenilicious
SET repo=RetroHursty69
SET theme=greenilicious
GOTO insttheme
:retroroid
SET repo=RetroHursty69
SET theme=retroroid
GOTO insttheme
:merryxmas
SET repo=RetroHursty69
SET theme=merryxmas
GOTO insttheme
:scv720
SET repo=Saracade
SET theme=scv720
GOTO insttheme
:insttheme
::Uses the variable set in the selection for git cloning.
CD /D %themesDir%
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
GOTO Selection2_IndThemes
::==============================================
::==============================================
:Selection2_AllThemes
::Using git clones all available themes into the theme folder for emulationstation.
CD /D "%themesDir%"
SET repo=RetroPie
SET theme=carbon
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroPie
SET theme=carbon-centered
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroPie
SET theme=carbon-nometa
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroPie
SET theme=simple
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroPie
SET theme=simple-dark
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroPie
SET theme=clean-look
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroPie
SET theme=color-pi
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroPie
SET theme=nbba
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroPie
SET theme=simplified-static-canela
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroPie
SET theme=turtle-pi
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroPie
SET theme=zoid
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=ehettervik
SET theme=pixel
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=ehettervik
SET theme=pixel-metadata
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=ehettervik
SET theme=pixel-tft
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=ehettervik
SET theme=luminous
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=ehettervik
SET theme=minilumi
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=ehettervik
SET theme=workbench
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=AmadhiX
SET theme=eudora
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=AmadhiX
SET theme=eudora-bigshot
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=AmadhiX
SET theme=eudora-concise
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
::SET repo=ChoccyHobNob
::SET theme=eudora-updated
::RMDIR "%theme%" /S /Q
::%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=InsecureSpike
SET theme=retroplay-clean-canela
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=InsecureSpike
SET theme=retroplay-clean-detail-canela
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=Omnija
SET theme=simpler-turtlepi
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=Omnija
SET theme=simpler-turtlemini
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=Omnija
SET theme=metro
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=lilbud
SET theme=material
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=mattrixk
SET theme=io
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=mattrixk
SET theme=metapixel
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=mattrixk
SET theme=spare
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=robertybob
SET theme=space
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=robertybob
SET theme=simplebigart
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=robertybob
SET theme=tv
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=HerbFargus
SET theme=tronkyfran
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=lilbud
SET theme=flat
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=lilbud
SET theme=flat-dark
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=lilbud
SET theme=minimal
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=lilbud
SET theme=switch-light
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=lilbud
SET theme=switch-dark
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=FlyingTomahawk
SET theme=futura-V
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=FlyingTomahawk
SET theme=futura-dark-V
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=G-rila
SET theme=fundamental
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=ruckage
SET theme=nes-mini
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=ruckage
SET theme=famicom-mini
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=ruckage
SET theme=snes-mini
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=anthonycaccese
SET theme=crt
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=anthonycaccese
SET theme=crt-centered
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=anthonycaccese
SET theme=art-book
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=anthonycaccese
SET theme=art-book-4-3
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=anthonycaccese
SET theme=art-book-pocket
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=anthonycaccese
SET theme=tft
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=TMNTturtleguy
SET theme=ComicBook
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=TMNTturtleguy
SET theme=ComicBook_4-3
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=TMNTturtleguy
SET theme=ComicBook_SE-Wheelart
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=TMNTturtleguy
SET theme=ComicBook_4-3_SE-Wheelart
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=ChoccyHobNob
SET theme=cygnus
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=dmmarti
SET theme=steampunk
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=dmmarti
SET theme=hurstyblue
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=dmmarti
SET theme=maximuspie
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=dmmarti
SET theme=showcase
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=dmmarti
SET theme=kidz
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=lipebello
SET theme=Retrorama
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=lipebello
SET theme=SpaceOddity
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=rxbrad
SET theme=gbz35
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=rxbrad
SET theme=gbz35-dark
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=garaine
SET theme=marioblue
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=garaine
SET theme=bigwood
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=MrTomixf
SET theme=Royal_Primicia
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroHursty69
SET theme=magazinemadness
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroHursty69
SET theme=stirling
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=lostless
SET theme=playstation
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=mrharias
SET theme=superdisplay
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=coinjunkie
SET theme=synthwave
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroHursty69
SET theme=boxalloyred
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroHursty69
SET theme=boxalloyblue
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroHursty69
SET theme=greenilicious
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroHursty69
SET theme=retroroid
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=RetroHursty69
SET theme=merryxmas
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
SET repo=Saracade
SET theme=scv720
RMDIR "%theme%" /S /Q
%toolsDir%\git\bin\git.exe clone --recursive https://github.com/%repo%/es-theme-%theme%.git %theme%
GOTO Selection2_ThemeManager
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection3
::Menu for managing RetroArch Updates, Core updates, and config.
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    MANAGE RETROARCH                 
echo ===========================================
echo =
echo =    1.) INSTALL RETROARCH v.%raVERSION%
echo =
echo -------------------------------------------
echo =
echo =    2.) UPDATE/INSTALL RETROARCH TO NIGHTLY BUILD
echo =
echo -------------------------------------------
echo =
echo =    3.) UPDATE RETROARCH CORES TO NIGHTLY BUILD
echo =
echo -------------------------------------------
echo =
echo =    4.) GENERATE CLEAN retroarch.cfg
echo =
echo -------------------------------------------
echo =
echo =    5.) Visit RetroArch website for versions  
echo =
echo -------------------------------------------
echo =
echo =    6.) RETURN TO MAIN MENU
echo =
echo ===========================================
echo =
CHOICE /C:123456 /N /T 30 /D 6 /M "=->  Enter selection (1,2,3,4,5,6): "
IF ERRORLEVEL ==6 GOTO Main
IF ERRORLEVEL ==5 GOTO Selection3_VisitRAweb
IF ERRORLEVEL ==4 GOTO Selection3_RACFG
IF ERRORLEVEL ==3 GOTO Selection3_updatecores
IF ERRORLEVEL ==2 GOTO Selection3_updateRAn
IF ERRORLEVEL ==1 GOTO Selection3_StartRAVerCheck
GOTO crash
::==============================================
::==============================================
:Selection3_StartRAVerCheck
::Starts checking Retroarch's version for update. Removes the RACheck folder to ensure comparison results are good.
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    CHECKING FOR RETROARCH UPDATES               
echo ===========================================
echo =
IF EXIST %tempDir%\RACheck\ RMDIR "%tempDir%\RACheck" /S /Q
GOTO Selection3_RACheck
::==============================================
::==============================================
:Selection3_RACheck
::Checks if retroarch is installed. If not it prompts to install. If already installed , compares the %raVERSION% variable with the "version" file in %RADir%\version. If different prompts to update.
IF NOT EXIST "%RADir%\retroarch.exe" GOTO Selection3_updateRAQN
IF NOT EXIST %tempDir%\RACheck\ MKDIR "%tempDir%\RACheck"
IF NOT EXIST "%RADir%\version" SET curRAVer=0
IF EXIST "%RADir%\version" SET /P curRAVer=<%RADir%\version
ECHO %curRAVer%>"%tempDir%\RACheck\currentRA.txt"
ECHO %raVERSION%>"%tempDir%\RACheck\newRA.txt"
CD /D "%tempDir%\RACheck"
SET /P currentRA=<currentRA.txt
SET /P newRA=<newRA.txt
ping 127.0.0.1 -n 2 >NUL
IF %currentRA%==%newRA% GOTO Selection3_RAUpToDate
GOTO Selection3_updateRAQ

::==============================================
::==============================================
:Selection3_RAUpToDate
::Lets the user know retroarch is up to date and does not need updates.
CLS
COLOR 0F
echo =
echo =
echo =
echo =
echo ===========================================
echo =    YOU ARE UP TO DATE!          
echo ===========================================
echo =
echo =    PRESS ANY KEY
echo =
PAUSE >NUL
GOTO Selection3
::==============================================
:Selection3_updateRAQ
::Prompts to update. Sends to Emulationstation installation (Newest available version)
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    AN UPDATE IS AVAILABLE!!
echo =
echo =    Do you want to reinstall or update 
echo =    to RetroArch and Cores v.%raVERSION%?
echo =
echo =    Your Version: v.%curRAVer%
echo =
echo ===========================================
echo =
echo =    1.) UPDATES RETROARCH FILES AND DIRECTORIES
echo =        (Backs up current install to %rp4winDir%\Backup) 
echo =
echo -------------------------------------------
echo =
echo =    2.) RETURN TO MANAGE RETROARCH MENU
echo =
echo -------------------------------------------
echo =
echo =    3.) RETURN TO MAIN MENU
echo =
echo ===========================================
echo =
CHOICE /C:123 /N /T 30 /D 3 /M "=->  Enter selection (1,2,3): "
IF ERRORLEVEL ==3 GOTO Main
IF ERRORLEVEL ==2 GOTO Selection3
IF ERRORLEVEL ==1 GOTO Selection3_updateRA
GOTO crash
::==============================================
::==============================================
:Selection3_updateRAQN
::Lets the user know that emulationstation is not installed. Prompts for installation. (Newest available version)
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    RETROARCH NOT FOUND!!
echo ===========================================
echo =
echo =    1.) INSTALL RETROARCH TO %RADir%
echo =
echo -------------------------------------------
echo =
echo =    2.) RETURN TO MANAGE RETROARCH MENU
echo =
echo -------------------------------------------
echo =
echo =    3.) RETURN TO MAIN MENU
echo =
echo ===========================================
echo =
CHOICE /C:123 /N /T 30 /D 3 /M "=->  Enter selection (1,2,3): "
IF ERRORLEVEL ==3 GOTO Main
IF ERRORLEVEL ==2 GOTO Selection3
IF ERRORLEVEL ==1 GOTO Selection3_updateRA
GOTO crash
::==============================================
::==============================================
:Selection3_updateRA
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =                                                                  
echo =    Backing up RetroArch folder                                 
echo =                                                                  
echo =    If contents do not exist, they will be skipped                
echo =                                                                  
%toolsDir%\7za\7za.exe a "%rp4winDir%\Backup\Backup_RetroArch_%FormDate%_%FormTime%.zip" "%RADir%"
echo =    moving System (bios, etc.) to Temp folder...
echo =  
IF EXIST %RADir%\system\ MOVE %RADir%\system %tempDir%\RA-system-tmp
echo =    moving overlays to Temp folder...
echo =  
IF EXIST %RADir%\overlays\GameBezels\ MOVE %RADir%\overlays\GameBezels %tempDir%\RA-overlays-GameBezel-tmp
echo ===========================================
echo =                                                                  
echo =    please wait...                             =
echo =  
IF EXIST %RADir%\ RMDIR "%RADir%" /S /Q
::RetroArch Updater. Archtecture check (x86 or x86_64)
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO Selection3_x64RA
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO Selection3_x86RA
	)

:Selection3_x64RA
::Installs RetroArch 1.10.2 to RP4Win\RetroArch. Cleans up all downloaded files when done. 64 bit
echo =
echo =
echo =
echo =
echo ===========================================
echo =    DOWNLOADING LATEST BUILD OF RETROARCH 
echo ===========================================
echo =                                                               
echo =    Downloading/Installing:    
echo =         - RetroArch v.%raVERSION% (64-bit)
echo =         - RetroArch Cores v.%raVERSION% (64-bit)
echo =                                                               
echo =    This will take some time, please wait...                          
echo =                                                               
echo =================================================================
echo =
echo =
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/stable/1.10.2/windows/x86_64/RetroArch.7z -o"%tempDir%\RetroArch_x64.7z"
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/stable/1.10.2/windows/x86_64/RetroArch_cores.7z -o"%tempDir%\RetroArch_x64_cores.7z"
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x64.7z" -o"%rp4winDir%" -aoa >NUL
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x64_cores.7z" -o"%rp4winDir%" -aoa >NUL
ping 127.0.0.1 -n 3 >NUL
IF EXIST %rp4winDir%\RetroArch-Win64\ REN %rp4winDir%\RetroArch-Win64 RetroArch
echo %raVERSION%>"%RADir%\version"
echo %raVERSION%>"%RADir%\cores\version"
IF EXIST %tempDir%\RA-system-tmp\ REN %RADir%\system system-backup
ping 127.0.0.1 -n 3 >nul
IF EXIST %tempDir%\RA-system-tmp\ MOVE %tempDir%\RA-system-tmp %RADir%\system
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 4 >NUL
IF EXIST "%tempDir%\RetroArch_x64.7z" DEL "%tempDir%\RetroArch_x64.7z"
IF EXIST "%tempDir%\RetroArch_x64_cores.7z" DEL "%tempDir%\RetroArch_x64_cores.7z"


GOTO Selection3_RACFG

:Selection3_x86RA
::Installs RetroArch 1.10.2 to RP4Win\RetroArch. Cleans up all downloaded files when done. 32 bit
echo =
echo =
echo =
echo =
echo ===========================================
echo =    DOWNLOADING LATEST BUILD OF RETROARCH 
echo ===========================================
echo =                                                               
echo =    Downloading/Installing:    
echo =         - RetroArch v.%raVERSION% (32-bit)
echo =         - RetroArch Cores v.%raVERSION% (32-bit)
echo =                                                               
echo =    This will take some time, please wait...                          
echo =                                                               
echo =================================================================
echo =
echo =
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/stable/1.10.2/windows/x86/RetroArch.7z -o"%tempDir%\RetroArch_x86.7z"
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/stable/1.10.2/windows/x86/RetroArch_cores.7z -o"%tempDir%\RetroArch_x86_cores.7z"
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x86.7z" -o"%rp4winDir%" -aoa >NUL
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x86_cores.7z" -o"%rp4winDir%" -aoa >NUL
ping 127.0.0.1 -n 3 >NUL
IF EXIST %rp4winDir%\RetroArch-Win32\ REN %rp4winDir%\RetroArch-Win32 RetroArch
echo %raVERSION%>"%RADir%\version"
echo %raVERSION%>"%RADir%\cores\version"
IF EXIST %tempDir%\RA-system-tmp\ REN %RADir%\system system-backup
ping 127.0.0.1 -n 3 >nul
IF EXIST %tempDir%\RA-system-tmp\ MOVE %tempDir%\RA-system-tmp %RADir%\system
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 4 >NUL
IF EXIST "%tempDir%\RetroArch_x86.7z" DEL "%tempDir%\RetroArch_x86.7z"
IF EXIST "%tempDir%\RetroArch_x86_cores.7z" DEL "%tempDir%\RetroArch_x86_cores.7z"
GOTO Selection3_RACFG
::==============================================
::==============================================
:Selection3_updateRAn
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =                                                                  
echo =    Backing up RetroArch folder                                 
echo =                                                                  
echo =    If contents do not exist, they will be skipped                
echo =                                                                  
%toolsDir%\7za\7za.exe a "%rp4winDir%\Backup\Backup_RetroArch_%FormDate%_%FormTime%.zip" "%RADir%"
echo =    moving System (bios, etc.) to Temp folder...
echo =  
IF EXIST %RADir%\system\ MOVE %RADir%\system %tempDir%\RA-system-tmp
echo =    moving overlays to Temp folder...
echo =  
IF EXIST %RADir%\overlays\GameBezels\ MOVE %RADir%\overlays\GameBezels %tempDir%\RA-overlays-GameBezel-tmp
echo ===========================================
echo =                                                                  
echo =    please wait...                             =
echo =  
IF EXIST %RADir%\ RMDIR "%RADir%" /S /Q
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO Selection3_x64RAn
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO Selection3_x86RAn
	)

:Selection3_x64RAn
::Installs RetroArch to RP4Win\RetroArch. Cleans up all downloaded files when done. x64 version of latest nightly
echo =
echo =
echo =
echo =
echo ===========================================
echo =    DOWNLOADING LATEST BUILD OF RETROARCH 
echo ===========================================
echo =                                                               
echo =    Downloading/Installing:    
echo =         - RetroArch Nightly Build (64-bit)
echo =         - RetroArch Cores Nightly Build (64-bit)
echo =                                                               
echo =    This will take some time, please wait...                          
echo =                                                               
echo =================================================================
echo =
echo =
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/nightly/windows/x86_64/RetroArch.7z -O "%tempDir%\RetroArch_x64.7z"
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/nightly/windows/x86_64/RetroArch_cores.7z -O "%tempDir%\RetroArch_x64_cores.7z"
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x64.7z" -o"%rp4winDir%" -aoa >NUL
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x64_cores.7z" -o"%rp4winDir%" -aoa >NUL
ping 127.0.0.1 -n 3 >NUL
IF EXIST %rp4winDir%\RetroArch-Win64\ REN %rp4winDir%\RetroArch-Win64 RetroArch
echo %raVERSION%>"%RADir%\version"
echo %raVERSION%>"%RADir%\cores\version"
IF EXIST %tempDir%\RA-system-tmp\ REN %RADir%\system system-backup
ping 127.0.0.1 -n 3 >nul
IF EXIST %tempDir%\RA-system-tmp\ MOVE %tempDir%\RA-system-tmp %RADir%\system
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 4 >NUL
IF EXIST "%tempDir%\RetroArch_x64.7z" DEL "%tempDir%\RetroArch_x64.7z"
IF EXIST "%tempDir%\RetroArch_x64_cores.7z" DEL "%tempDir%\RetroArch_x64_cores.7z"
GOTO completed

:Selection3_x86RAn
::Installs RetroArch to RP4Win\RetroArch. Cleans up all downloaded files when done. 32 bit version of the latest nightly
echo =
echo =
echo =
echo =
echo ===========================================
echo =    DOWNLOADING LATEST BUILD OF RETROARCH 
echo ===========================================
echo =                                                               
echo =    Downloading/Installing:    
echo =         - RetroArch Nightly Build (32-bit)
echo =         - RetroArch Cores Nightly Build (32-bit)
echo =                                                               
echo =    This will take some time, please wait...                          
echo =                                                               
echo =================================================================
echo =
echo =
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/nightly/windows/x86/RetroArch.7z -o"%tempDir%\RetroArch_x86.7z"
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/nightly/windows/x86/RetroArch_cores.7z -o"%tempDir%\RetroArch_x86_cores.7z"
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x86.7z" -o"%rp4winDir%" -aoa >NUL
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x86_cores.7z" -o"%rp4winDir%" -aoa >NUL
ping 127.0.0.1 -n 3 >NUL
IF EXIST %rp4winDir%\RetroArch-Win32\ REN %rp4winDir%\RetroArch-Win32 RetroArch
echo %raVERSION%>"%RADir%\version"
echo %raVERSION%>"%RADir%\cores\version"
IF EXIST %tempDir%\RA-system-tmp\ REN %RADir%\system system-backup
ping 127.0.0.1 -n 3 >nul
IF EXIST %tempDir%\RA-system-tmp\ MOVE %tempDir%\RA-system-tmp %RADir%\system
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 4 >NUL
IF EXIST "%tempDir%\RetroArch_x86.7z" DEL "%tempDir%\RetroArch_x86.7z"
IF EXIST "%tempDir%\RetroArch_x86_cores.7z" DEL "%tempDir%\RetroArch_x86_cores.7z"
GOTO completed
::==============================================
::==============================================
:Selection3_updatecores
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =                                                                  
echo =    Backing up RetroArch\cores folder                                 
echo =                                                                  
echo =    If contents do not exist, they will be skipped                
echo =                                                                  
%toolsDir%\7za\7za.exe a "%rp4winDir%\Backup\Backup_RetroArch_cores_%FormDate%_%FormTime%.zip" "%RADir%\cores"
::Checks architecture for installing/updating retroarch cores
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO Selection3_x64core
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO Selection3_x86core
	)

:Selection3_x64core
::Install all RetroArch nightly cores - 64 bit
echo =
echo =
echo =
echo =
echo =================================================================
echo =    Downloading RetroArch cores. This will take some time     
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/nightly/windows/x86_64/RetroArch_cores.7z -O "%tempDir%\RetroArch_x64_cores.7z"
IF EXIST "%tempDir%\RetroArch_x64_cores.7z" RMDIR "%RADir%\cores" /S /Q
IF NOT EXIST %RADir%\cores\ MKDIR "%RADir%\cores"
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x64_cores.7z" -o"%tempDir%" -aoa >NUL
IF EXIST %tempDir%\RetroArch-Win64\cores\ MOVE %tempDir%\RetroArch-Win64\cores %RADir%\cores
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 4 >NUL
IF EXIST "%tempDir%\RetroArch_x64_cores.7z" DEL "%tempDir%\RetroArch_x64_cores.7z"
IF EXIST %tempDir%\RetroArch-Win64\ RMDIR "%tempDir%\RetroArch-Win64" /S /Q
GOTO completed

:Selection3_x86core
::Install all RetroArch cores - 32 bit
echo =
echo =
echo =
echo =
echo =================================================================
echo =    Downloading RetroArch cores. This will take some time     
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://buildbot.libretro.com/nightly/windows/x86/RetroArch_cores.7z -o"%tempDir%\RetroArch_x86_cores.7z"
IF EXIST "%tempDir%\RetroArch_x86_cores.7z" RMDIR "%RADir%\cores" /S /Q
IF NOT EXIST %RADir%\cores\ MKDIR "%RADir%\cores"
%toolsDir%\7za\7za.exe x "%tempDir%\RetroArch_x86_cores.7z" -o"%tempDir%" -aoa >NUL
IF EXIST %tempDir%\RetroArch-Win32\cores\ MOVE %tempDir%\RetroArch-Win32\cores %RADir%\cores
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 4 >NUL
IF EXIST "%tempDir%\RetroArch_x86_cores.7z" DEL "%tempDir%\RetroArch_x86_cores.7z"
IF EXIST %tempDir%\RetroArch-Win32\ RMDIR "%tempDir%\RetroArch-Win32" /S /Q
GOTO completed
::==============================================
::==============================================
:Selection3_RACFG
:: THIS HAD BEEN SHORT CIRCUITED FOR NOW!!!!
:: remove the following 4 lines to go back to normal operation 
IF EXIST "%tempDir%\BrandNewBlank" GOTO Selection4_InstallAllEmu
IF EXIST "%tempDir%\BrandNewDef" GOTO Selection4_InstallAllEmu
IF EXIST "%tempDir%\BrandNewCus" GOTO Selection4_InstallAllEmu
GOTO completed
::Generates a retroarch config file. 99% default. Adds the start+select opening of the retroarch menu in game. RetroPie accomplishes this by using custom mapping with RetroPad, but I found this to be simpler.
CLS
echo config_save_on_exit = "true">%RADir%\retroarch.cfg
echo core_updater_buildbot_url = "http://buildbot.libretro.com/nightly/windows/x86_64/latest/">>%RADir%\retroarch.cfg
echo core_updater_buildbot_assets_url = "http://buildbot.libretro.com/assets/">>%RADir%\retroarch.cfg
echo libretro_directory = ":\cores">>%RADir%\retroarch.cfg
echo libretro_info_path = ":\info">>%RADir%\retroarch.cfg
echo content_database_path = ":\database\rdb">>%RADir%\retroarch.cfg
echo cheat_database_path = ":\cheats">>%RADir%\retroarch.cfg
echo content_history_path = ":\content_history.lpl">>%RADir%\retroarch.cfg
echo content_favorites_path = ":\content_favorites.lpl">>%RADir%\retroarch.cfg
echo content_music_history_path = ":\content_music_history.lpl">>%RADir%\retroarch.cfg
echo content_video_history_path = ":\content_video_history.lpl">>%RADir%\retroarch.cfg
echo content_image_history_path = ":\content_image_history.lpl">>%RADir%\retroarch.cfg
echo cursor_directory = ":\database\cursors">>%RADir%\retroarch.cfg
echo screenshot_directory = ":\screenshots">>%RADir%\retroarch.cfg
echo system_directory = ":\system">>%RADir%\retroarch.cfg
echo input_remapping_directory = ":\config\remaps">>%RADir%\retroarch.cfg
echo video_shader_dir = ":\shaders">>%RADir%\retroarch.cfg
echo video_filter_dir = ":\filters\video">>%RADir%\retroarch.cfg
echo core_assets_directory = ":\downloads">>%RADir%\retroarch.cfg
echo assets_directory = ":\assets">>%RADir%\retroarch.cfg
echo dynamic_wallpapers_directory = ":\assets\wallpapers">>%RADir%\retroarch.cfg
echo thumbnails_directory = ":\thumbnails">>%RADir%\retroarch.cfg
echo playlist_directory = ":\playlists">>%RADir%\retroarch.cfg
echo joypad_autoconfig_dir = ":\autoconfig">>%RADir%\retroarch.cfg
echo audio_filter_dir = ":\filters\audio">>%RADir%\retroarch.cfg
echo savefile_directory = ":\saves">>%RADir%\retroarch.cfg
echo savestate_directory = ":\states">>%RADir%\retroarch.cfg
echo rgui_browser_directory = "default">>%RADir%\retroarch.cfg
echo rgui_config_directory = ":\config">>%RADir%\retroarch.cfg
echo overlay_directory = ":\overlays">>%RADir%\retroarch.cfg
echo screenshot_directory = ":\screenshots">>%RADir%\retroarch.cfg
echo video_driver = "gl">>%RADir%\retroarch.cfg
echo record_driver = "ffmpeg">>%RADir%\retroarch.cfg
echo camera_driver = "null">>%RADir%\retroarch.cfg
echo wifi_driver = "null">>%RADir%\retroarch.cfg
echo location_driver = "null">>%RADir%\retroarch.cfg
echo menu_driver = "xmb">>%RADir%\retroarch.cfg
echo audio_driver = "xaudio">>%RADir%\retroarch.cfg
echo audio_resampler = "sinc">>%RADir%\retroarch.cfg
echo input_driver = "dinput">>%RADir%\retroarch.cfg
echo input_joypad_driver = "xinput">>%RADir%\retroarch.cfg
echo video_aspect_ratio = "-1.000000">>%RADir%\retroarch.cfg
echo video_scale = "3.000000">>%RADir%\retroarch.cfg
echo video_refresh_rate = "60.000027">>%RADir%\retroarch.cfg
echo audio_rate_control_delta = "0.005000">>%RADir%\retroarch.cfg
echo audio_max_timing_skew = "0.050000">>%RADir%\retroarch.cfg
echo audio_volume = "0.000000">>%RADir%\retroarch.cfg
echo audio_mixer_volume = "0.000000">>%RADir%\retroarch.cfg
echo input_overlay_opacity = "0.700000">>%RADir%\retroarch.cfg
echo input_overlay_scale = "1.000000">>%RADir%\retroarch.cfg
echo menu_wallpaper_opacity = "0.300000">>%RADir%\retroarch.cfg
echo menu_framebuffer_opacity = "0.900000">>%RADir%\retroarch.cfg
echo menu_footer_opacity = "1.000000">>%RADir%\retroarch.cfg
echo menu_header_opacity = "1.000000">>%RADir%\retroarch.cfg
echo video_message_pos_x = "0.050000">>%RADir%\retroarch.cfg
echo video_message_pos_y = "0.050000">>%RADir%\retroarch.cfg
echo video_font_size = "32.000000">>%RADir%\retroarch.cfg
echo fastforward_ratio = "0.000000">>%RADir%\retroarch.cfg
echo slowmotion_ratio = "3.000000">>%RADir%\retroarch.cfg
echo input_axis_threshold = "0.500000">>%RADir%\retroarch.cfg
echo state_slot = "0">>%RADir%\retroarch.cfg
echo netplay_check_frames = "30">>%RADir%\retroarch.cfg
echo audio_wasapi_sh_buffer_length = "-16">>%RADir%\retroarch.cfg
echo input_bind_timeout = "5">>%RADir%\retroarch.cfg
echo input_turbo_period = "6">>%RADir%\retroarch.cfg
echo input_duty_cycle = "3">>%RADir%\retroarch.cfg
echo input_max_users = "5">>%RADir%\retroarch.cfg
echo input_menu_toggle_gamepad_combo = "4">>%RADir%\retroarch.cfg
echo audio_latency = "64">>%RADir%\retroarch.cfg
echo audio_block_frames = "0">>%RADir%\retroarch.cfg
echo rewind_granularity = "1">>%RADir%\retroarch.cfg
echo autosave_interval = "0">>%RADir%\retroarch.cfg
echo libretro_log_level = "1">>%RADir%\retroarch.cfg
echo keyboard_gamepad_mapping_type = "1">>%RADir%\retroarch.cfg
echo input_poll_type_behavior = "2">>%RADir%\retroarch.cfg
echo video_monitor_index = "0">>%RADir%\retroarch.cfg
echo video_fullscreen_x = "0">>%RADir%\retroarch.cfg
echo video_fullscreen_y = "0">>%RADir%\retroarch.cfg
echo video_window_x = "0">>%RADir%\retroarch.cfg
echo video_window_y = "0">>%RADir%\retroarch.cfg
echo network_cmd_port = "55355">>%RADir%\retroarch.cfg
echo network_remote_base_port = "55400">>%RADir%\retroarch.cfg
echo dpi_override_value = "200">>%RADir%\retroarch.cfg
echo menu_thumbnails = "3">>%RADir%\retroarch.cfg
echo xmb_alpha_factor = "75">>%RADir%\retroarch.cfg
echo xmb_scale_factor = "100">>%RADir%\retroarch.cfg
echo xmb_theme = "0">>%RADir%\retroarch.cfg
echo xmb_menu_color_theme = "4">>%RADir%\retroarch.cfg
echo materialui_menu_color_theme = "0">>%RADir%\retroarch.cfg
echo menu_shader_pipeline = "2">>%RADir%\retroarch.cfg
echo audio_out_rate = "48000">>%RADir%\retroarch.cfg
echo custom_viewport_width = "960">>%RADir%\retroarch.cfg
echo custom_viewport_height = "720">>%RADir%\retroarch.cfg
echo custom_viewport_x = "0">>%RADir%\retroarch.cfg
echo custom_viewport_y = "0">>%RADir%\retroarch.cfg
echo content_history_size = "100">>%RADir%\retroarch.cfg
echo video_hard_sync_frames = "0">>%RADir%\retroarch.cfg
echo video_frame_delay = "0">>%RADir%\retroarch.cfg
echo video_max_swapchain_images = "3">>%RADir%\retroarch.cfg
echo video_swap_interval = "1">>%RADir%\retroarch.cfg
echo video_rotation = "0">>%RADir%\retroarch.cfg
echo aspect_ratio_index = "21">>%RADir%\retroarch.cfg
echo netplay_ip_port = "55435">>%RADir%\retroarch.cfg
echo netplay_input_latency_frames_min = "0">>%RADir%\retroarch.cfg
echo netplay_input_latency_frames_range = "0">>%RADir%\retroarch.cfg
echo user_language = "0">>%RADir%\retroarch.cfg
echo bundle_assets_extract_version_current = "0">>%RADir%\retroarch.cfg
echo bundle_assets_extract_last_version = "0">>%RADir%\retroarch.cfg
echo input_overlay_show_physical_inputs_port = "0">>%RADir%\retroarch.cfg
echo input_device_p1 = "0">>%RADir%\retroarch.cfg
echo input_player1_joypad_index = "0">>%RADir%\retroarch.cfg
echo input_libretro_device_p1 = "1">>%RADir%\retroarch.cfg
echo input_player1_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player1_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p2 = "0">>%RADir%\retroarch.cfg
echo input_player2_joypad_index = "1">>%RADir%\retroarch.cfg
echo input_libretro_device_p2 = "1">>%RADir%\retroarch.cfg
echo input_player2_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player2_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p3 = "0">>%RADir%\retroarch.cfg
echo input_player3_joypad_index = "2">>%RADir%\retroarch.cfg
echo input_libretro_device_p3 = "1">>%RADir%\retroarch.cfg
echo input_player3_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player3_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p4 = "0">>%RADir%\retroarch.cfg
echo input_player4_joypad_index = "3">>%RADir%\retroarch.cfg
echo input_libretro_device_p4 = "1">>%RADir%\retroarch.cfg
echo input_player4_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player4_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p5 = "0">>%RADir%\retroarch.cfg
echo input_player5_joypad_index = "4">>%RADir%\retroarch.cfg
echo input_libretro_device_p5 = "1">>%RADir%\retroarch.cfg
echo input_player5_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player5_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p6 = "0">>%RADir%\retroarch.cfg
echo input_player6_joypad_index = "5">>%RADir%\retroarch.cfg
echo input_libretro_device_p6 = "1">>%RADir%\retroarch.cfg
echo input_player6_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player6_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p7 = "0">>%RADir%\retroarch.cfg
echo input_player7_joypad_index = "6">>%RADir%\retroarch.cfg
echo input_libretro_device_p7 = "1">>%RADir%\retroarch.cfg
echo input_player7_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player7_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p8 = "0">>%RADir%\retroarch.cfg
echo input_player8_joypad_index = "7">>%RADir%\retroarch.cfg
echo input_libretro_device_p8 = "1">>%RADir%\retroarch.cfg
echo input_player8_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player8_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p9 = "0">>%RADir%\retroarch.cfg
echo input_player9_joypad_index = "8">>%RADir%\retroarch.cfg
echo input_libretro_device_p9 = "1">>%RADir%\retroarch.cfg
echo input_player9_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player9_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p10 = "0">>%RADir%\retroarch.cfg
echo input_player10_joypad_index = "9">>%RADir%\retroarch.cfg
echo input_libretro_device_p10 = "1">>%RADir%\retroarch.cfg
echo input_player10_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player10_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p11 = "0">>%RADir%\retroarch.cfg
echo input_player11_joypad_index = "10">>%RADir%\retroarch.cfg
echo input_libretro_device_p11 = "1">>%RADir%\retroarch.cfg
echo input_player11_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player11_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p12 = "0">>%RADir%\retroarch.cfg
echo input_player12_joypad_index = "11">>%RADir%\retroarch.cfg
echo input_libretro_device_p12 = "1">>%RADir%\retroarch.cfg
echo input_player12_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player12_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p13 = "0">>%RADir%\retroarch.cfg
echo input_player13_joypad_index = "12">>%RADir%\retroarch.cfg
echo input_libretro_device_p13 = "1">>%RADir%\retroarch.cfg
echo input_player13_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player13_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p14 = "0">>%RADir%\retroarch.cfg
echo input_player14_joypad_index = "13">>%RADir%\retroarch.cfg
echo input_libretro_device_p14 = "1">>%RADir%\retroarch.cfg
echo input_player14_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player14_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p15 = "0">>%RADir%\retroarch.cfg
echo input_player15_joypad_index = "14">>%RADir%\retroarch.cfg
echo input_libretro_device_p15 = "1">>%RADir%\retroarch.cfg
echo input_player15_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player15_mouse_index = "0">>%RADir%\retroarch.cfg
echo input_device_p16 = "0">>%RADir%\retroarch.cfg
echo input_player16_joypad_index = "15">>%RADir%\retroarch.cfg
echo input_libretro_device_p16 = "1">>%RADir%\retroarch.cfg
echo input_player16_analog_dpad_mode = "0">>%RADir%\retroarch.cfg
echo input_player16_mouse_index = "0">>%RADir%\retroarch.cfg
echo ui_companion_start_on_boot = "true">>%RADir%\retroarch.cfg
echo ui_companion_enable = "false">>%RADir%\retroarch.cfg
echo video_gpu_record = "false">>%RADir%\retroarch.cfg
echo input_remap_binds_enable = "true">>%RADir%\retroarch.cfg
echo all_users_control_menu = "false">>%RADir%\retroarch.cfg
echo menu_swap_ok_cancel_buttons = "true">>%RADir%\retroarch.cfg
echo netplay_public_announce = "true">>%RADir%\retroarch.cfg
echo netplay_start_as_spectator = "false">>%RADir%\retroarch.cfg
echo netplay_allow_slaves = "true">>%RADir%\retroarch.cfg
echo netplay_require_slaves = "false">>%RADir%\retroarch.cfg
echo netplay_stateless_mode = "false">>%RADir%\retroarch.cfg
echo netplay_client_swap_input = "true">>%RADir%\retroarch.cfg
echo netplay_use_mitm_server = "false">>%RADir%\retroarch.cfg
echo input_descriptor_label_show = "true">>%RADir%\retroarch.cfg
echo input_descriptor_hide_unbound = "false">>%RADir%\retroarch.cfg
echo load_dummy_on_core_shutdown = "true">>%RADir%\retroarch.cfg
echo check_firmware_before_loading = "false">>%RADir%\retroarch.cfg
echo builtin_mediaplayer_enable = "true">>%RADir%\retroarch.cfg
echo builtin_imageviewer_enable = "true">>%RADir%\retroarch.cfg
echo fps_show = "false">>%RADir%\retroarch.cfg
echo ui_menubar_enable = "true">>%RADir%\retroarch.cfg
echo suspend_screensaver_enable = "true">>%RADir%\retroarch.cfg
echo rewind_enable = "false">>%RADir%\retroarch.cfg
echo audio_sync = "true">>%RADir%\retroarch.cfg
echo video_shader_enable = "false">>%RADir%\retroarch.cfg
echo video_aspect_ratio_auto = "false">>%RADir%\retroarch.cfg
echo video_allow_rotate = "true">>%RADir%\retroarch.cfg
echo video_windowed_fullscreen = "true">>%RADir%\retroarch.cfg
echo video_crop_overscan = "true">>%RADir%\retroarch.cfg
echo video_scale_integer = "false">>%RADir%\retroarch.cfg
echo video_smooth = "true">>%RADir%\retroarch.cfg
echo video_force_aspect = "true">>%RADir%\retroarch.cfg
echo video_threaded = "false">>%RADir%\retroarch.cfg
echo video_shared_context = "false">>%RADir%\retroarch.cfg
echo auto_screenshot_filename = "true">>%RADir%\retroarch.cfg
echo video_force_srgb_disable = "false">>%RADir%\retroarch.cfg
echo video_fullscreen = "true">>%RADir%\retroarch.cfg
echo bundle_assets_extract_enable = "false">>%RADir%\retroarch.cfg
echo video_vsync = "true">>%RADir%\retroarch.cfg
echo video_hard_sync = "false">>%RADir%\retroarch.cfg
echo video_black_frame_insertion = "false">>%RADir%\retroarch.cfg
echo video_disable_composition = "false">>%RADir%\retroarch.cfg
echo pause_nonactive = "true">>%RADir%\retroarch.cfg
echo video_gpu_screenshot = "true">>%RADir%\retroarch.cfg
echo video_post_filter_record = "false">>%RADir%\retroarch.cfg
echo keyboard_gamepad_enable = "true">>%RADir%\retroarch.cfg
echo core_set_supports_no_game_enable = "true">>%RADir%\retroarch.cfg
echo audio_enable = "true">>%RADir%\retroarch.cfg
echo audio_mute_enable = "false">>%RADir%\retroarch.cfg
echo audio_mixer_mute_enable = "false">>%RADir%\retroarch.cfg
echo location_allow = "false">>%RADir%\retroarch.cfg
echo video_font_enable = "true">>%RADir%\retroarch.cfg
echo core_updater_auto_extract_archive = "true">>%RADir%\retroarch.cfg
echo camera_allow = "false">>%RADir%\retroarch.cfg
echo menu_unified_controls = "false">>%RADir%\retroarch.cfg
echo threaded_data_runloop_enable = "true">>%RADir%\retroarch.cfg
echo menu_throttle_framerate = "true">>%RADir%\retroarch.cfg
echo menu_linear_filter = "true">>%RADir%\retroarch.cfg
echo menu_horizontal_animation = "true">>%RADir%\retroarch.cfg
echo dpi_override_enable = "true">>%RADir%\retroarch.cfg
echo menu_pause_libretro = "true">>%RADir%\retroarch.cfg
echo menu_mouse_enable = "true">>%RADir%\retroarch.cfg
echo menu_pointer_enable = "false">>%RADir%\retroarch.cfg
echo menu_timedate_enable = "true">>%RADir%\retroarch.cfg
echo menu_battery_level_enable = "true">>%RADir%\retroarch.cfg
echo menu_core_enable = "true">>%RADir%\retroarch.cfg
echo menu_dynamic_wallpaper_enable = "false">>%RADir%\retroarch.cfg
echo materialui_icons_enable = "true">>%RADir%\retroarch.cfg
echo xmb_shadows_enable = "true">>%RADir%\retroarch.cfg
echo xmb_show_settings = "true">>%RADir%\retroarch.cfg
echo xmb_show_favorites = "true">>%RADir%\retroarch.cfg
echo xmb_show_images = "true">>%RADir%\retroarch.cfg
echo xmb_show_music = "true">>%RADir%\retroarch.cfg
echo menu_show_online_updater = "true">>%RADir%\retroarch.cfg
echo menu_show_core_updater = "true">>%RADir%\retroarch.cfg
echo xmb_show_video = "true">>%RADir%\retroarch.cfg
echo xmb_show_netplay = "true">>%RADir%\retroarch.cfg
echo xmb_show_history = "true">>%RADir%\retroarch.cfg
echo xmb_show_add = "true">>%RADir%\retroarch.cfg
echo filter_by_current_core = "false">>%RADir%\retroarch.cfg
echo rgui_show_start_screen = "false">>%RADir%\retroarch.cfg
echo menu_navigation_wraparound_enable = "true">>%RADir%\retroarch.cfg
echo menu_navigation_browser_filter_supported_extensions_enable = "true">>%RADir%\retroarch.cfg
echo menu_show_advanced_settings = "true">>%RADir%\retroarch.cfg
echo cheevos_enable = "false">>%RADir%\retroarch.cfg
echo cheevos_test_unofficial = "false">>%RADir%\retroarch.cfg
echo cheevos_hardcore_mode_enable = "false">>%RADir%\retroarch.cfg
echo cheevos_verbose_enable = "false">>%RADir%\retroarch.cfg
echo input_overlay_enable = "true">>%RADir%\retroarch.cfg
echo input_overlay_enable_autopreferred = "true">>%RADir%\retroarch.cfg
echo input_overlay_show_physical_inputs = "false">>%RADir%\retroarch.cfg
echo input_overlay_hide_in_menu = "true">>%RADir%\retroarch.cfg
echo network_cmd_enable = "false">>%RADir%\retroarch.cfg
echo stdin_cmd_enable = "false">>%RADir%\retroarch.cfg
echo network_remote_enable = "false">>%RADir%\retroarch.cfg
echo netplay_nat_traversal = "true">>%RADir%\retroarch.cfg
echo block_sram_overwrite = "false">>%RADir%\retroarch.cfg
echo savestate_auto_index = "false">>%RADir%\retroarch.cfg
echo savestate_auto_save = "false">>%RADir%\retroarch.cfg
echo savestate_auto_load = "false">>%RADir%\retroarch.cfg
echo savestate_thumbnail_enable = "false">>%RADir%\retroarch.cfg
echo history_list_enable = "true">>%RADir%\retroarch.cfg
echo playlist_entry_remove = "true">>%RADir%\retroarch.cfg
echo game_specific_options = "true">>%RADir%\retroarch.cfg
echo auto_overrides_enable = "true">>%RADir%\retroarch.cfg
echo auto_remaps_enable = "true">>%RADir%\retroarch.cfg
echo auto_shaders_enable = "true">>%RADir%\retroarch.cfg
echo sort_savefiles_enable = "false">>%RADir%\retroarch.cfg
echo sort_savestates_enable = "false">>%RADir%\retroarch.cfg
echo show_hidden_files = "false">>%RADir%\retroarch.cfg
echo input_autodetect_enable = "true">>%RADir%\retroarch.cfg
echo audio_rate_control = "true">>%RADir%\retroarch.cfg
echo audio_wasapi_exclusive_mode = "true">>%RADir%\retroarch.cfg
echo audio_wasapi_float_format = "false">>%RADir%\retroarch.cfg
echo savestates_in_content_dir = "false">>%RADir%\retroarch.cfg
echo savefiles_in_content_dir = "false">>%RADir%\retroarch.cfg
echo systemfiles_in_content_dir = "false">>%RADir%\retroarch.cfg
echo screenshots_in_content_dir = "false">>%RADir%\retroarch.cfg
echo custom_bgm_enable = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p1 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p2 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p3 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p4 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p5 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p6 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p7 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p8 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p9 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p10 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p11 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p12 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p13 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p14 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p15 = "false">>%RADir%\retroarch.cfg
echo network_remote_enable_user_p16 = "false">>%RADir%\retroarch.cfg
echo log_verbosity = "false">>%RADir%\retroarch.cfg
echo perfcnt_enable = "false">>%RADir%\retroarch.cfg
echo video_message_color = "ffffff">>%RADir%\retroarch.cfg
echo menu_entry_normal_color = "ffffffff">>%RADir%\retroarch.cfg
echo menu_entry_hover_color = "ff64ff64">>%RADir%\retroarch.cfg
echo menu_title_color = "ff64ff64">>%RADir%\retroarch.cfg
echo gamma_correction = "false">>%RADir%\retroarch.cfg
echo flicker_filter_enable = "false">>%RADir%\retroarch.cfg
echo soft_filter_enable = "false">>%RADir%\retroarch.cfg
echo soft_filter_index = "0">>%RADir%\retroarch.cfg
echo current_resolution_id = "0">>%RADir%\retroarch.cfg
echo flicker_filter_index = "0">>%RADir%\retroarch.cfg
echo input_player1_b = "z">>%RADir%\retroarch.cfg
echo input_player1_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_y = "a">>%RADir%\retroarch.cfg
echo input_player1_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_select = "rshift">>%RADir%\retroarch.cfg
echo input_player1_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_start = "enter">>%RADir%\retroarch.cfg
echo input_player1_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_up = "up">>%RADir%\retroarch.cfg
echo input_player1_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_down = "down">>%RADir%\retroarch.cfg
echo input_player1_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_left = "left">>%RADir%\retroarch.cfg
echo input_player1_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_right = "right">>%RADir%\retroarch.cfg
echo input_player1_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_a = "x">>%RADir%\retroarch.cfg
echo input_player1_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_x = "s">>%RADir%\retroarch.cfg
echo input_player1_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_l = "q">>%RADir%\retroarch.cfg
echo input_player1_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_r = "w">>%RADir%\retroarch.cfg
echo input_player1_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player1_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player1_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player1_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player1_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player1_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player1_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player1_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_toggle_fast_forward = "space">>%RADir%\retroarch.cfg
echo input_toggle_fast_forward_btn = "nul">>%RADir%\retroarch.cfg
echo input_toggle_fast_forward_axis = "nul">>%RADir%\retroarch.cfg
echo input_hold_fast_forward = "l">>%RADir%\retroarch.cfg
echo input_hold_fast_forward_btn = "nul">>%RADir%\retroarch.cfg
echo input_hold_fast_forward_axis = "nul">>%RADir%\retroarch.cfg
echo input_load_state = "f4">>%RADir%\retroarch.cfg
echo input_load_state_btn = "nul">>%RADir%\retroarch.cfg
echo input_load_state_axis = "nul">>%RADir%\retroarch.cfg
echo input_save_state = "f2">>%RADir%\retroarch.cfg
echo input_save_state_btn = "nul">>%RADir%\retroarch.cfg
echo input_save_state_axis = "nul">>%RADir%\retroarch.cfg
echo input_toggle_fullscreen = "f">>%RADir%\retroarch.cfg
echo input_toggle_fullscreen_btn = "nul">>%RADir%\retroarch.cfg
echo input_toggle_fullscreen_axis = "nul">>%RADir%\retroarch.cfg
echo input_exit_emulator = "escape">>%RADir%\retroarch.cfg
echo input_exit_emulator_btn = "nul">>%RADir%\retroarch.cfg
echo input_exit_emulator_axis = "nul">>%RADir%\retroarch.cfg
echo input_state_slot_increase = "f7">>%RADir%\retroarch.cfg
echo input_state_slot_increase_btn = "nul">>%RADir%\retroarch.cfg
echo input_state_slot_increase_axis = "nul">>%RADir%\retroarch.cfg
echo input_state_slot_decrease = "f6">>%RADir%\retroarch.cfg
echo input_state_slot_decrease_btn = "nul">>%RADir%\retroarch.cfg
echo input_state_slot_decrease_axis = "nul">>%RADir%\retroarch.cfg
echo input_rewind = "r">>%RADir%\retroarch.cfg
echo input_rewind_btn = "nul">>%RADir%\retroarch.cfg
echo input_rewind_axis = "nul">>%RADir%\retroarch.cfg
echo input_movie_record_toggle = "o">>%RADir%\retroarch.cfg
echo input_movie_record_toggle_btn = "nul">>%RADir%\retroarch.cfg
echo input_movie_record_toggle_axis = "nul">>%RADir%\retroarch.cfg
echo input_pause_toggle = "p">>%RADir%\retroarch.cfg
echo input_pause_toggle_btn = "nul">>%RADir%\retroarch.cfg
echo input_pause_toggle_axis = "nul">>%RADir%\retroarch.cfg
echo input_frame_advance = "k">>%RADir%\retroarch.cfg
echo input_frame_advance_btn = "nul">>%RADir%\retroarch.cfg
echo input_frame_advance_axis = "nul">>%RADir%\retroarch.cfg
echo input_reset = "h">>%RADir%\retroarch.cfg
echo input_reset_btn = "nul">>%RADir%\retroarch.cfg
echo input_reset_axis = "nul">>%RADir%\retroarch.cfg
echo input_shader_next = "m">>%RADir%\retroarch.cfg
echo input_shader_next_btn = "nul">>%RADir%\retroarch.cfg
echo input_shader_next_axis = "nul">>%RADir%\retroarch.cfg
echo input_shader_prev = "n">>%RADir%\retroarch.cfg
echo input_shader_prev_btn = "nul">>%RADir%\retroarch.cfg
echo input_shader_prev_axis = "nul">>%RADir%\retroarch.cfg
echo input_cheat_index_plus = "y">>%RADir%\retroarch.cfg
echo input_cheat_index_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_cheat_index_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_cheat_index_minus = "t">>%RADir%\retroarch.cfg
echo input_cheat_index_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_cheat_index_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_cheat_toggle = "u">>%RADir%\retroarch.cfg
echo input_cheat_toggle_btn = "nul">>%RADir%\retroarch.cfg
echo input_cheat_toggle_axis = "nul">>%RADir%\retroarch.cfg
echo input_screenshot = "f8">>%RADir%\retroarch.cfg
echo input_screenshot_btn = "nul">>%RADir%\retroarch.cfg
echo input_screenshot_axis = "nul">>%RADir%\retroarch.cfg
echo input_audio_mute = "f9">>%RADir%\retroarch.cfg
echo input_audio_mute_btn = "nul">>%RADir%\retroarch.cfg
echo input_audio_mute_axis = "nul">>%RADir%\retroarch.cfg
echo input_osk_toggle = "f12">>%RADir%\retroarch.cfg
echo input_osk_toggle_btn = "nul">>%RADir%\retroarch.cfg
echo input_osk_toggle_axis = "nul">>%RADir%\retroarch.cfg
echo input_netplay_flip_players_1_2 = "nul">>%RADir%\retroarch.cfg
echo input_netplay_flip_players_1_2_btn = "nul">>%RADir%\retroarch.cfg
echo input_netplay_flip_players_1_2_axis = "nul">>%RADir%\retroarch.cfg
echo input_netplay_game_watch = "i">>%RADir%\retroarch.cfg
echo input_netplay_game_watch_btn = "nul">>%RADir%\retroarch.cfg
echo input_netplay_game_watch_axis = "nul">>%RADir%\retroarch.cfg
echo input_slowmotion = "e">>%RADir%\retroarch.cfg
echo input_slowmotion_btn = "nul">>%RADir%\retroarch.cfg
echo input_slowmotion_axis = "nul">>%RADir%\retroarch.cfg
echo input_enable_hotkey = "nul">>%RADir%\retroarch.cfg
echo input_enable_hotkey_btn = "nul">>%RADir%\retroarch.cfg
echo input_enable_hotkey_axis = "nul">>%RADir%\retroarch.cfg
echo input_volume_up = "add">>%RADir%\retroarch.cfg
echo input_volume_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_volume_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_volume_down = "subtract">>%RADir%\retroarch.cfg
echo input_volume_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_volume_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_overlay_next = "nul">>%RADir%\retroarch.cfg
echo input_overlay_next_btn = "nul">>%RADir%\retroarch.cfg
echo input_overlay_next_axis = "nul">>%RADir%\retroarch.cfg
echo input_disk_eject_toggle = "nul">>%RADir%\retroarch.cfg
echo input_disk_eject_toggle_btn = "nul">>%RADir%\retroarch.cfg
echo input_disk_eject_toggle_axis = "nul">>%RADir%\retroarch.cfg
echo input_disk_next = "nul">>%RADir%\retroarch.cfg
echo input_disk_next_btn = "nul">>%RADir%\retroarch.cfg
echo input_disk_next_axis = "nul">>%RADir%\retroarch.cfg
echo input_disk_prev = "nul">>%RADir%\retroarch.cfg
echo input_disk_prev_btn = "nul">>%RADir%\retroarch.cfg
echo input_disk_prev_axis = "nul">>%RADir%\retroarch.cfg
echo input_grab_mouse_toggle = "f11">>%RADir%\retroarch.cfg
echo input_grab_mouse_toggle_btn = "nul">>%RADir%\retroarch.cfg
echo input_grab_mouse_toggle_axis = "nul">>%RADir%\retroarch.cfg
echo input_game_focus_toggle = "scroll_lock">>%RADir%\retroarch.cfg
echo input_game_focus_toggle_btn = "nul">>%RADir%\retroarch.cfg
echo input_game_focus_toggle_axis = "nul">>%RADir%\retroarch.cfg
echo input_menu_toggle = "f1">>%RADir%\retroarch.cfg
echo input_menu_toggle_btn = "nul">>%RADir%\retroarch.cfg
echo input_menu_toggle_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_b = "nul">>%RADir%\retroarch.cfg
echo input_player2_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_y = "nul">>%RADir%\retroarch.cfg
echo input_player2_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_select = "nul">>%RADir%\retroarch.cfg
echo input_player2_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_start = "nul">>%RADir%\retroarch.cfg
echo input_player2_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_up = "nul">>%RADir%\retroarch.cfg
echo input_player2_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_down = "nul">>%RADir%\retroarch.cfg
echo input_player2_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_left = "nul">>%RADir%\retroarch.cfg
echo input_player2_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_right = "nul">>%RADir%\retroarch.cfg
echo input_player2_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_a = "nul">>%RADir%\retroarch.cfg
echo input_player2_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_x = "nul">>%RADir%\retroarch.cfg
echo input_player2_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_l = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_r = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player2_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player2_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player2_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player2_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player2_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player2_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player2_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_b = "nul">>%RADir%\retroarch.cfg
echo input_player3_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_y = "nul">>%RADir%\retroarch.cfg
echo input_player3_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_select = "nul">>%RADir%\retroarch.cfg
echo input_player3_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_start = "nul">>%RADir%\retroarch.cfg
echo input_player3_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_up = "nul">>%RADir%\retroarch.cfg
echo input_player3_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_down = "nul">>%RADir%\retroarch.cfg
echo input_player3_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_left = "nul">>%RADir%\retroarch.cfg
echo input_player3_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_right = "nul">>%RADir%\retroarch.cfg
echo input_player3_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_a = "nul">>%RADir%\retroarch.cfg
echo input_player3_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_x = "nul">>%RADir%\retroarch.cfg
echo input_player3_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_l = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_r = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player3_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player3_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player3_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player3_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player3_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player3_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player3_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_b = "nul">>%RADir%\retroarch.cfg
echo input_player4_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_y = "nul">>%RADir%\retroarch.cfg
echo input_player4_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_select = "nul">>%RADir%\retroarch.cfg
echo input_player4_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_start = "nul">>%RADir%\retroarch.cfg
echo input_player4_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_up = "nul">>%RADir%\retroarch.cfg
echo input_player4_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_down = "nul">>%RADir%\retroarch.cfg
echo input_player4_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_left = "nul">>%RADir%\retroarch.cfg
echo input_player4_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_right = "nul">>%RADir%\retroarch.cfg
echo input_player4_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_a = "nul">>%RADir%\retroarch.cfg
echo input_player4_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_x = "nul">>%RADir%\retroarch.cfg
echo input_player4_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_l = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_r = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player4_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player4_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player4_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player4_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player4_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player4_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player4_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_b = "nul">>%RADir%\retroarch.cfg
echo input_player5_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_y = "nul">>%RADir%\retroarch.cfg
echo input_player5_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_select = "nul">>%RADir%\retroarch.cfg
echo input_player5_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_start = "nul">>%RADir%\retroarch.cfg
echo input_player5_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_up = "nul">>%RADir%\retroarch.cfg
echo input_player5_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_down = "nul">>%RADir%\retroarch.cfg
echo input_player5_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_left = "nul">>%RADir%\retroarch.cfg
echo input_player5_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_right = "nul">>%RADir%\retroarch.cfg
echo input_player5_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_a = "nul">>%RADir%\retroarch.cfg
echo input_player5_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_x = "nul">>%RADir%\retroarch.cfg
echo input_player5_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_l = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_r = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player5_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player5_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player5_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player5_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player5_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player5_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player5_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_b = "nul">>%RADir%\retroarch.cfg
echo input_player6_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_y = "nul">>%RADir%\retroarch.cfg
echo input_player6_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_select = "nul">>%RADir%\retroarch.cfg
echo input_player6_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_start = "nul">>%RADir%\retroarch.cfg
echo input_player6_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_up = "nul">>%RADir%\retroarch.cfg
echo input_player6_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_down = "nul">>%RADir%\retroarch.cfg
echo input_player6_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_left = "nul">>%RADir%\retroarch.cfg
echo input_player6_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_right = "nul">>%RADir%\retroarch.cfg
echo input_player6_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_a = "nul">>%RADir%\retroarch.cfg
echo input_player6_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_x = "nul">>%RADir%\retroarch.cfg
echo input_player6_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_l = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_r = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player6_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player6_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player6_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player6_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player6_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player6_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player6_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_b = "nul">>%RADir%\retroarch.cfg
echo input_player7_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_y = "nul">>%RADir%\retroarch.cfg
echo input_player7_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_select = "nul">>%RADir%\retroarch.cfg
echo input_player7_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_start = "nul">>%RADir%\retroarch.cfg
echo input_player7_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_up = "nul">>%RADir%\retroarch.cfg
echo input_player7_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_down = "nul">>%RADir%\retroarch.cfg
echo input_player7_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_left = "nul">>%RADir%\retroarch.cfg
echo input_player7_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_right = "nul">>%RADir%\retroarch.cfg
echo input_player7_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_a = "nul">>%RADir%\retroarch.cfg
echo input_player7_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_x = "nul">>%RADir%\retroarch.cfg
echo input_player7_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_l = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_r = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player7_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player7_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player7_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player7_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player7_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player7_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player7_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_b = "nul">>%RADir%\retroarch.cfg
echo input_player8_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_y = "nul">>%RADir%\retroarch.cfg
echo input_player8_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_select = "nul">>%RADir%\retroarch.cfg
echo input_player8_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_start = "nul">>%RADir%\retroarch.cfg
echo input_player8_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_up = "nul">>%RADir%\retroarch.cfg
echo input_player8_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_down = "nul">>%RADir%\retroarch.cfg
echo input_player8_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_left = "nul">>%RADir%\retroarch.cfg
echo input_player8_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_right = "nul">>%RADir%\retroarch.cfg
echo input_player8_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_a = "nul">>%RADir%\retroarch.cfg
echo input_player8_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_x = "nul">>%RADir%\retroarch.cfg
echo input_player8_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_l = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_r = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player8_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player8_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player8_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player8_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player8_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player8_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player8_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_b = "nul">>%RADir%\retroarch.cfg
echo input_player9_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_y = "nul">>%RADir%\retroarch.cfg
echo input_player9_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_select = "nul">>%RADir%\retroarch.cfg
echo input_player9_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_start = "nul">>%RADir%\retroarch.cfg
echo input_player9_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_up = "nul">>%RADir%\retroarch.cfg
echo input_player9_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_down = "nul">>%RADir%\retroarch.cfg
echo input_player9_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_left = "nul">>%RADir%\retroarch.cfg
echo input_player9_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_right = "nul">>%RADir%\retroarch.cfg
echo input_player9_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_a = "nul">>%RADir%\retroarch.cfg
echo input_player9_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_x = "nul">>%RADir%\retroarch.cfg
echo input_player9_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_l = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_r = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player9_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player9_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player9_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player9_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player9_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player9_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player9_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_b = "nul">>%RADir%\retroarch.cfg
echo input_player10_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_y = "nul">>%RADir%\retroarch.cfg
echo input_player10_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_select = "nul">>%RADir%\retroarch.cfg
echo input_player10_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_start = "nul">>%RADir%\retroarch.cfg
echo input_player10_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_up = "nul">>%RADir%\retroarch.cfg
echo input_player10_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_down = "nul">>%RADir%\retroarch.cfg
echo input_player10_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_left = "nul">>%RADir%\retroarch.cfg
echo input_player10_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_right = "nul">>%RADir%\retroarch.cfg
echo input_player10_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_a = "nul">>%RADir%\retroarch.cfg
echo input_player10_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_x = "nul">>%RADir%\retroarch.cfg
echo input_player10_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_l = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_r = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player10_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player10_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player10_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player10_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player10_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player10_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player10_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_b = "nul">>%RADir%\retroarch.cfg
echo input_player11_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_y = "nul">>%RADir%\retroarch.cfg
echo input_player11_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_select = "nul">>%RADir%\retroarch.cfg
echo input_player11_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_start = "nul">>%RADir%\retroarch.cfg
echo input_player11_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_up = "nul">>%RADir%\retroarch.cfg
echo input_player11_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_down = "nul">>%RADir%\retroarch.cfg
echo input_player11_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_left = "nul">>%RADir%\retroarch.cfg
echo input_player11_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_right = "nul">>%RADir%\retroarch.cfg
echo input_player11_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_a = "nul">>%RADir%\retroarch.cfg
echo input_player11_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_x = "nul">>%RADir%\retroarch.cfg
echo input_player11_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_l = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_r = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player11_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player11_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player11_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player11_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player11_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player11_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player11_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_b = "nul">>%RADir%\retroarch.cfg
echo input_player12_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_y = "nul">>%RADir%\retroarch.cfg
echo input_player12_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_select = "nul">>%RADir%\retroarch.cfg
echo input_player12_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_start = "nul">>%RADir%\retroarch.cfg
echo input_player12_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_up = "nul">>%RADir%\retroarch.cfg
echo input_player12_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_down = "nul">>%RADir%\retroarch.cfg
echo input_player12_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_left = "nul">>%RADir%\retroarch.cfg
echo input_player12_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_right = "nul">>%RADir%\retroarch.cfg
echo input_player12_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_a = "nul">>%RADir%\retroarch.cfg
echo input_player12_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_x = "nul">>%RADir%\retroarch.cfg
echo input_player12_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_l = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_r = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player12_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player12_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player12_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player12_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player12_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player12_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player12_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_b = "nul">>%RADir%\retroarch.cfg
echo input_player13_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_y = "nul">>%RADir%\retroarch.cfg
echo input_player13_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_select = "nul">>%RADir%\retroarch.cfg
echo input_player13_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_start = "nul">>%RADir%\retroarch.cfg
echo input_player13_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_up = "nul">>%RADir%\retroarch.cfg
echo input_player13_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_down = "nul">>%RADir%\retroarch.cfg
echo input_player13_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_left = "nul">>%RADir%\retroarch.cfg
echo input_player13_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_right = "nul">>%RADir%\retroarch.cfg
echo input_player13_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_a = "nul">>%RADir%\retroarch.cfg
echo input_player13_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_x = "nul">>%RADir%\retroarch.cfg
echo input_player13_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_l = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_r = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player13_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player13_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player13_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player13_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player13_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player13_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player13_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_b = "nul">>%RADir%\retroarch.cfg
echo input_player14_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_y = "nul">>%RADir%\retroarch.cfg
echo input_player14_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_select = "nul">>%RADir%\retroarch.cfg
echo input_player14_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_start = "nul">>%RADir%\retroarch.cfg
echo input_player14_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_up = "nul">>%RADir%\retroarch.cfg
echo input_player14_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_down = "nul">>%RADir%\retroarch.cfg
echo input_player14_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_left = "nul">>%RADir%\retroarch.cfg
echo input_player14_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_right = "nul">>%RADir%\retroarch.cfg
echo input_player14_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_a = "nul">>%RADir%\retroarch.cfg
echo input_player14_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_x = "nul">>%RADir%\retroarch.cfg
echo input_player14_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_l = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_r = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player14_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player14_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player14_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player14_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player14_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player14_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player14_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_b = "nul">>%RADir%\retroarch.cfg
echo input_player15_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_y = "nul">>%RADir%\retroarch.cfg
echo input_player15_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_select = "nul">>%RADir%\retroarch.cfg
echo input_player15_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_start = "nul">>%RADir%\retroarch.cfg
echo input_player15_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_up = "nul">>%RADir%\retroarch.cfg
echo input_player15_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_down = "nul">>%RADir%\retroarch.cfg
echo input_player15_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_left = "nul">>%RADir%\retroarch.cfg
echo input_player15_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_right = "nul">>%RADir%\retroarch.cfg
echo input_player15_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_a = "nul">>%RADir%\retroarch.cfg
echo input_player15_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_x = "nul">>%RADir%\retroarch.cfg
echo input_player15_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_l = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_r = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player15_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player15_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player15_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player15_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player15_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player15_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player15_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_b = "nul">>%RADir%\retroarch.cfg
echo input_player16_b_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_b_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_y = "nul">>%RADir%\retroarch.cfg
echo input_player16_y_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_y_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_select = "nul">>%RADir%\retroarch.cfg
echo input_player16_select_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_select_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_start = "nul">>%RADir%\retroarch.cfg
echo input_player16_start_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_start_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_up = "nul">>%RADir%\retroarch.cfg
echo input_player16_up_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_up_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_down = "nul">>%RADir%\retroarch.cfg
echo input_player16_down_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_down_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_left = "nul">>%RADir%\retroarch.cfg
echo input_player16_left_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_left_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_right = "nul">>%RADir%\retroarch.cfg
echo input_player16_right_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_right_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_a = "nul">>%RADir%\retroarch.cfg
echo input_player16_a_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_a_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_x = "nul">>%RADir%\retroarch.cfg
echo input_player16_x_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_x_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_l = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_r = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_l2 = "nul">>%RADir%\retroarch.cfg
echo input_player16_l2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_l2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_r2 = "nul">>%RADir%\retroarch.cfg
echo input_player16_r2_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_r2_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_l3 = "nul">>%RADir%\retroarch.cfg
echo input_player16_l3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_l3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_r3 = "nul">>%RADir%\retroarch.cfg
echo input_player16_r3_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_r3_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_l_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_x_plus = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_x_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_x_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_x_minus = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_x_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_x_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_y_plus = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_y_plus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_y_plus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_y_minus = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_y_minus_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_r_y_minus_axis = "nul">>%RADir%\retroarch.cfg
echo input_player16_turbo = "nul">>%RADir%\retroarch.cfg
echo input_player16_turbo_btn = "nul">>%RADir%\retroarch.cfg
echo input_player16_turbo_axis = "nul">>%RADir%\retroarch.cfg
echo video_msg_bgcolor_opacity = "1.000000">>%RADir%\retroarch.cfg
echo keymapper_port = "0">>%RADir%\retroarch.cfg
echo video_msg_bgcolor_red = "0">>%RADir%\retroarch.cfg
echo video_msg_bgcolor_green = "0">>%RADir%\retroarch.cfg
echo video_msg_bgcolor_blue = "0">>%RADir%\retroarch.cfg
echo framecount_show = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_take_screenshot = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_save_load_state = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_undo_save_load_state = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_add_to_favorites = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_options = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_controls = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_cheats = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_shaders = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_save_core_overrides = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_save_game_overrides = "true">>%RADir%\retroarch.cfg
echo quick_menu_show_information = "true">>%RADir%\retroarch.cfg
echo kiosk_mode_enable = "false">>%RADir%\retroarch.cfg
echo menu_show_load_core = "true">>%RADir%\retroarch.cfg
echo menu_show_load_content = "true">>%RADir%\retroarch.cfg
echo menu_show_information = "true">>%RADir%\retroarch.cfg
echo menu_show_configurations = "true">>%RADir%\retroarch.cfg
echo menu_show_help = "true">>%RADir%\retroarch.cfg
echo menu_show_quit_retroarch = "true">>%RADir%\retroarch.cfg
echo menu_show_reboot = "true">>%RADir%\retroarch.cfg
echo keymapper_enable = "true">>%RADir%\retroarch.cfg
echo playlist_entry_rename = "true">>%RADir%\retroarch.cfg
echo video_msg_bgcolor_enable = "false">>%RADir%\retroarch.cfg
echo cheevos_leaderboards_enable = "false">>%RADir%\retroarch.cfg
echo xmb_font = "">>%RADir%\retroarch.cfg
echo xmb_show_settings_password = "">>%RADir%\retroarch.cfg
echo kiosk_mode_password = "">>%RADir%\retroarch.cfg
echo netplay_nickname = "">>%RADir%\retroarch.cfg
echo video_filter = "">>%RADir%\retroarch.cfg
echo audio_dsp_plugin = "">>%RADir%\retroarch.cfg
echo netplay_ip_address = "">>%RADir%\retroarch.cfg
echo netplay_password = "">>%RADir%\retroarch.cfg
echo netplay_spectate_password = "">>%RADir%\retroarch.cfg
echo core_options_path = "">>%RADir%\retroarch.cfg
echo video_shader = "">>%RADir%\retroarch.cfg
echo menu_wallpaper = "">>%RADir%\retroarch.cfg
echo input_overlay = "">>%RADir%\retroarch.cfg
echo video_font_path = "">>%RADir%\retroarch.cfg
echo content_history_dir = "">>%RADir%\retroarch.cfg
echo cache_directory = "">>%RADir%\retroarch.cfg
echo resampler_directory = "">>%RADir%\retroarch.cfg
echo recording_output_directory = "">>%RADir%\retroarch.cfg
echo recording_config_directory = "">>%RADir%\retroarch.cfg
echo xmb_font = "">>%RADir%\retroarch.cfg
echo playlist_names = "">>%RADir%\retroarch.cfg
echo playlist_cores = "">>%RADir%\retroarch.cfg
echo audio_device = "">>%RADir%\retroarch.cfg
echo camera_device = "">>%RADir%\retroarch.cfg
echo video_context_driver = "">>%RADir%\retroarch.cfg
echo input_keyboard_layout = "">>%RADir%\retroarch.cfg
echo bundle_assets_src_path = "">>%RADir%\retroarch.cfg
echo bundle_assets_dst_path = "">>%RADir%\retroarch.cfg
echo bundle_assets_dst_path_subdir = "">>%RADir%\retroarch.cfg
IF EXIST "%tempDir%\BrandNewBlank" GOTO Selection4_InstallAllEmu
IF EXIST "%tempDir%\BrandNewDef" GOTO Selection4_InstallAllEmu
IF EXIST "%tempDir%\BrandNewCus" GOTO Selection4_InstallAllEmu
GOTO completed
::==============================================
::==============================================
:Selection3_VisitRAweb
::Review and/or manual install for  RetroArch and Cores
CLS
echo =
echo =
echo =
echo =
echo ================================================
echo =                                              
echo =    Visit or manual download/install:       
echo =        - RetroArch and Cores                   
echo =                                              
echo ================================================
echo = 
echo =    This will open RetroArch's website site in 
echo =    MS Edge web browser.
echo =
echo =      - Look for RetroArch.7z and RetroArch_cores.7z in any of the following:
echo =           - stable - version number - windows - x86_64
echo =           - stable - version number - windows - x86
echo =           - nightly - windows - x86_64
echo =           - nightly - windows - x86
echo = 
echo =      - Backup your existing RetroArch folder
echo =           - 'drive-letter:\RRP4Win\RetroArch'
echo =
echo =      - Download RetroArch, Cores or both and extract the 7z files 
echo =           - rename 'RetroArch-Win64' to 'RetroArch' folder (64bit)
echo =           - rename 'RetroArch-Win32' to 'RetroArch' folder (32bit)
echo =           - ensure 'cores' folder is inside 'RetroArch' folder
echo = 
echo =
echo =   
echo =    NOTE: If malware is detected, DO NOT INSTALL / USE !!!
echo =    Use other version that is free of malware  OR  skip this.
echo = 
echo =
START microsoft-edge:https://buildbot.libretro.com/
PAUSE >NUL
GOTO Selection3
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection4
::Checks if the Emulator Folder is created. Creates if not.
IF EXIST %systemsDir%\ GOTO Selection4_AdditionalEmu
IF NOT EXIST %systemsDir%\ MKDIR "%systemsDir%"
GOTO Selection4_AdditionalEmu
::==============================================
:Selection4_AdditionalEmu
::Menu for managing additional programs
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Manage Additional Programs             
echo ===========================================
echo =
echo =    1.) INSTALL ALL ADDITIONAL EMULATORS (Disabled until 1.0 release)
echo =
echo -------------------------------------------
echo =
echo =    2.) INSTALL AppleWin (Apple II Emulator)
echo =
echo =    3.) INSTALL Beebem (BBC Micro Emulator)
echo =
echo =    4.) INSTALL BlueMSX (MSX 1/2/2+/Turbo R, Colecovision, SpectraVideo, SG-1000, SC-3000 Emulator)
echo =
echo =    5.) INSTALL Cemu (WiiU Emulator)
echo =
echo =    6.) INSTALL Citra (Canary) (3DS Emulator)
echo =
echo =    7.) INSTALL ColEm (ColecoVision Emulator)
echo =
echo =    8.) INSTALL Classic99 (TI-99/4A Emulator)
echo =
echo =    9.) INSTALL Cxbx-Reloaded (XBOX Emulator) 
echo =
echo -------------------------------------------
echo =    N.) Next Page
echo =    P.) Previous Page
echo ===========================================
echo =
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Main
IF ERRORLEVEL ==11 GOTO Selection4_AdditionalEmu3
IF ERRORLEVEL ==10 GOTO Selection4_AdditionalEmu2
IF ERRORLEVEL ==9 GOTO Cxbx-Reloaded
IF ERRORLEVEL ==8 GOTO Classic99
IF ERRORLEVEL ==7 GOTO ColEm
IF ERRORLEVEL ==6 GOTO Citra
IF ERRORLEVEL ==5 GOTO Cemu
IF ERRORLEVEL ==4 GOTO BlueMSX
IF ERRORLEVEL ==3 GOTO BeebEm
IF ERRORLEVEL ==2 GOTO AppleWin
IF ERRORLEVEL ==1 GOTO NoFeat
::IF ERRORLEVEL ==1 GOTO Selection4_InstallAllEmu
GOTO crash
::==============================================
:Selection4_AdditionalEmu2
::Additional Emulators continued.
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Manage Additional Programs             
echo ===========================================
echo =
echo =    1.) INSTALL Daphne (Laserdisc Emulator)
echo =
echo =    2.) INSTALL Dolphin (Gamecube and Wii Emulator)
echo =
echo =    3.) INSTALL Hatari (Atari ST/STE/TT/Falcon Emulator)
echo =
echo =    4.) INSTALL jzIntv (Intellivision Emulator) Used on IntelliVoice and ECS games
echo =
echo =    5.) INSTALL MAME
echo =
echo =    6.) INSTALL OpenBor
echo =
echo =    7.) INSTALL PCSX2 (PS2 Emulator)
echo =
echo =    8.) INSTALL PPSSPP (PSP Emulator)
echo =
echo =    9.) INSTALL RPCS3 (Playstation 3 Emulator)
echo =
echo -------------------------------------------
echo =    N.) Next Page
echo =    P.) Previous Page
echo ===========================================
echo =
CHOICE /C:123456789NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,7,8,9,N,P,Q): "
IF ERRORLEVEL ==12 GOTO Main
IF ERRORLEVEL ==11 GOTO Selection4_AdditionalEmu
IF ERRORLEVEL ==10 GOTO Selection4_AdditionalEmu3
IF ERRORLEVEL ==9 GOTO Rpcs3
IF ERRORLEVEL ==8 GOTO PPSSPP
IF ERRORLEVEL ==7 GOTO PCSX2
IF ERRORLEVEL ==6 GOTO OpenBOREmu
IF ERRORLEVEL ==5 GOTO MAME
IF ERRORLEVEL ==4 GOTO jzIntv
IF ERRORLEVEL ==3 GOTO Hatari
IF ERRORLEVEL ==2 GOTO Dolphin
IF ERRORLEVEL ==1 GOTO Daphne
GOTO crash
::==============================================
:Selection4_AdditionalEmu3
::Additional Emulators continued.
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Manage Additional Programs             
echo ===========================================
echo =
echo =    1.) INSTALL Vita3k (PS Vita Emulator)
echo =
echo =    2.) INSTALL Xemu (XBOX Emulator)
echo =
echo =    3.) INSTALL xenia (XBOX 360 Emulator) 
echo =
echo =    4.) INSTALL XRoar (Dragon and CoCo Emulator)
echo =
echo =    5.) INSTALL Yuzu (Switch Development Emulator)
echo =
echo =    6.) INSTALL VICE (Commodore 64 Emulator)
echo =
echo -------------------------------------------
echo =    N.) Next Page
echo =    P.) Previous Page
echo ===========================================
echo =
CHOICE /C:123456NPQ /N /T 30 /D Q /M "=->  Enter selection (1,2,3,4,5,6,N,P,Q): "
IF ERRORLEVEL ==9 GOTO Main
IF ERRORLEVEL ==8 GOTO Selection4_AdditionalEmu2
IF ERRORLEVEL ==7 GOTO Selection4_AdditionalEmu
IF ERRORLEVEL ==6 GOTO VICE
IF ERRORLEVEL ==5 GOTO Yuzu
IF ERRORLEVEL ==4 GOTO XRoar
IF ERRORLEVEL ==3 GOTO Xenia
IF ERRORLEVEL ==2 GOTO Xemu
IF ERRORLEVEL ==1 GOTO Vita3k
GOTO crash
::==============================================
:Selection4_InstallAllEmu
::Secondary Emulator Folder check. May not be needed
IF EXIST %systemsDir%\ GOTO Selection4_StartAllEmu
IF EXIST %systemsDir%\ RMDIR "%systemsDir%" /S /Q
IF NOT EXIST %systemsDir%\ MKDIR "%systemsDir%"
GOTO Selection4_StartAllEmu
::==============================================
:Selection4_StartAllEmu
::Creates a temporary file (tmp.txt) for the GOTO statements after each emulator is installed. Allows chaining emulator installation.
echo This file is temporary. You should never see it>"%systemsDir%\tmp.txt"
GOTO AppleWin
::==============================================
::==============================================
:AppleWin
::Installs AppleWin (Apple II Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING APPLEWIN                      
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/AppleWin/AppleWin/releases/download/v1.30.9.0/AppleWin1.30.9.0.zip -O "%tempDir%\AppleWin.zip"
MKDIR "%systemsDir%\AppleWin"
%toolsDir%\7za\7za.exe x "%tempDir%\AppleWin.zip" -o"%systemsDir%\AppleWin" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 3 >NUL
DEL "%tempDir%\AppleWin.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO BeebEm
GOTO completed
::==============================================
::==============================================
:BeebEm
::Installs Beebem (BBC Micro Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING BEEBEM                      
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://www.mkw.me.uk/beebem/BeebEm417.zip -O "%tempDir%\BeebEm.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\BeebEm.zip" -o"%systemsDir%" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\BeebEm.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO BlueMSX
GOTO completed
::==============================================
::==============================================
:BlueMSX
::Installs BlueMSX (MSX 1/2/2+/Turbo R, Colecovision, SpectraVideo, SG-1000, SC-3000 Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING BLUEMSX                     
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://bluemsx.msxblue.com/rel_download/blueMSXv282full.zip -O "%tempDir%\BlueMSX.zip"
MKDIR "%systemsDir%\BlueMSX"
%toolsDir%\7za\7za.exe x "%tempDir%\BlueMSX.zip" -o"%systemsDir%\BlueMSX" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 3 >NUL
DEL "%tempDir%\BlueMSX.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Cemu
GOTO completed
::==============================================
::==============================================
:Cemu
::Installs Cemu (WiiU Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING CEMU                         
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://cemu.info/releases/cemu_1.26.2.zip -O "%tempDir%\cemu.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\cemu.zip" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\cemu_1.26.2" cemu
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\cemu.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Citra
GOTO completed
::==============================================
::==============================================
:Citra
::Installs Citra (Canary) (3DS Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING CITRA                         
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/citra-emu/citra-nightly/releases/download/nightly-1757/citra-windows-mingw-20220305-ac98458.7z -O "%tempDir%\citra.7z"
%toolsDir%\7za\7za.exe x "%tempDir%\citra.7z" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\nightly-mingw" Citra
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\citra.7z"
IF EXIST "%systemsDir%\tmp.txt" GOTO ColEm
GOTO completed
::==============================================
::==============================================
:ColEm
::Installs ColEm (ColecoVision Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING COLEM                        
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://fms.komkon.org/ColEm/ColEm56-Windows-bin.zip -O "%tempDir%\ColEm.zip"
ping 127.0.0.1 -n 2 >NUL
MKDIR "%systemsDir%\ColEm"
%toolsDir%\7za\7za.exe x "%tempDir%\ColEm.zip" -o"%systemsDir%\ColEm" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\ColEm.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Classic99
GOTO completed
::==============================================
::==============================================
:Classic99
::Installs Classic99 (TI-99/4A Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING CLASSIC99
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/tursilion/classic99/raw/main/dist/classic99.zip -O "%tempDir%\classic99.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\classic99.zip" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\classic99" Classic99
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\classic99.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Cxbx-Reloaded
GOTO completed
::==============================================
::==============================================
:Cxbx-Reloaded
::Installs Cxbx-Reloaded (XBOX Emulator) 
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING CXBX-RELOADED
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/Cxbx-Reloaded/Cxbx-Reloaded/releases/download/CI-6788bf1/CxbxReloaded-Release-VS2022.zip -O "%tempDir%\Cxbx-Reloaded.zip"
ping 127.0.0.1 -n 2 >NUL
MKDIR "%systemsDir%\Cxbx-Reloaded"
%toolsDir%\7za\7za.exe x "%tempDir%\Cxbx-Reloaded.zip" -o"%systemsDir%\Cxbx-Reloaded" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\Cxbx-Reloaded.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Daphne
GOTO completed
::==============================================
::==============================================
:Daphne
::Installs Daphne (Laserdisc Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING DAPHNE                       
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://www.daphne-emu.com/download/daphne-1.0v-win32.zip -O "%tempDir%\Daphne.zip"
MKDIR "%systemsDir%\Daphne"
%toolsDir%\7za\7za.exe x "%tempDir%\Daphne.zip" -o"%systemsDir%\Daphne" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\Daphne.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Dolphin
GOTO completed
::==============================================
::==============================================
:Dolphin
::Installs Dolphin (Gamecube and Wii Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING DOLPHIN                       
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://dl.dolphin-emu.org/builds/c0/39/dolphin-master-5.0-16101-x64.7z -O "%tempDir%\Dolphin.7z"
%toolsDir%\7za\7za.exe x "%tempDir%\Dolphin.7z" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\Dolphin-x64" Dolphin
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\Dolphin.7z"
IF EXIST "%systemsDir%\tmp.txt" GOTO Hatari
GOTO completed
::==============================================
::==============================================
:Hatari
::Installs Hatari (Atari ST/STE/TT/Falcon Emulator)
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO hatari64
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO hatari32
	)

:hatari32
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING HATARI 32-BIT
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://download.tuxfamily.org/hatari/2.3.1/hatari-2.3.1_windows.zip -O "%tempDir%\Hatari32.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\Hatari32.zip" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\hatari-2.3.1_windows" Hatari
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\Hatari32.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO jzIntv
GOTO completed

:hatari64
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING HATARI 64-BIT
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://download.tuxfamily.org/hatari/2.3.1/hatari-2.3.1_windows64.zip -O "%tempDir%\Hatari64.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\Hatari64.zip" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\hatari-2.3.1_windows64" Hatari
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\Hatari64.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO jzIntv
GOTO completed
::==============================================
::==============================================
:jzIntv
::Installs jzIntv (Intellivision Emulator) Use this for IntelliVoice and ECS games (Entertainment Computer System)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING JZINTV                      
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://spatula-city.org/~im14u2c/intv/dl/jzintv-20200712-win32-sdl2.zip -O "%tempDir%\jzintv.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\jzintv.zip" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\jzintv-20200712-win32-sdl2" jzIntv
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\jzIntv.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO MAME
GOTO completed
::==============================================
::==============================================
:MAME
::Installs MAME 64 bit
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING MAME                      
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/mamedev/mame/releases/download/mame0241/mame0241b_64bit.exe -O "%tempDir%\Mame64.exe"
MKDIR "%systemsDir%\Mame"
%toolsDir%\7za\7za.exe x "%tempDir%\Mame64.exe" -o"%systemsDir%\Mame" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\Mame64.exe"
IF EXIST "%systemsDir%\tmp.txt" GOTO OpenBOR
GOTO completed
::==============================================
::==============================================
:OpenBOR
::
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING OPENBOR                      
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/DCurrent/openbor/releases/download/v6391/OpenBOR.v3.0.Build.6391.7z -O "%tempDir%\OpenBOR.7z"
%toolsDir%\7za\7za.exe x "%tempDir%\OpenBOR.7z" -o"%tempDir%" -aoa >NUL
MKDIR "%systemsDir%\OpenBOR"
MOVE "%tempDir%\OpenBOR v3.0 Build 6391\WINDOWS\OpenBOR" "%systemsDir%\OpenBOR"
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
RMDIR "%tempDir%\OpenBOR v3.0 Build 6391" /S /Q
DEL "%tempDir%\OpenBOR.7z"
IF EXIST "%systemsDir%\tmp.txt" GOTO PCSX2
GOTO completed
::==============================================
::==============================================
:PCSX2
::Installs PCSX2 (PS2 Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING PCSX2                       
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/PCSX2/pcsx2/releases/download/v1.6.0/pcsx2-1.6.0-binaries.7z -O "%tempDir%\PCSX2.7z"
%toolsDir%\7za\7za.exe x "%tempDir%\PCSX2.7z" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\PCSX2 1.6.0" pcsx2
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\PCSX2.7z"
IF EXIST "%systemsDir%\tmp.txt" GOTO PPSSPP
GOTO completed
::==============================================
::==============================================
:Pcsx2Dev
::Installs Pcsx2-Dev (PS2 Emulator) 



::==============================================
::==============================================
:PPSSPP
::Installs PPSSPP (Playstation Portable Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING PPSSPP                      
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://www.ppsspp.org/files/1_12_3/ppsspp_win.zip -O "%tempDir%\ppsspp.zip"
MKDIR "%systemsDir%\ppsspp"
%toolsDir%\7za\7za.exe x "%tempDir%\ppsspp.zip" -o"%systemsDir%\ppsspp" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\ppsspp.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Rpcs3
GOTO completed
::==============================================
::==============================================
:Rpcs3
::Installs RPCS3 (Playstation 3 Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING RPCS3                      
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/RPCS3/rpcs3-binaries-win/releases/download/build-e650d11b306b5ea07b4f30a6e59de679d70a0b0a/rpcs3-v0.0.21-13371-e650d11b_win64.7z -O "%tempDir%\rpcs3.7z"
MKDIR "%systemsDir%\Rpcs3"
%toolsDir%\7za\7za.exe x "%tempDir%\rpcs3.7z" -o"%systemsDir%\Rpcs3" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\rpcs3.7z"
IF EXIST "%systemsDir%\tmp.txt" GOTO Vita3k
GOTO completed
::==============================================
::==============================================
:Vita3k
::Installs Vita3k (PS Vita Emulator)

CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING VITA3K
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/Vita3K/Vita3K/releases/download/continous/windows-latest.zip -O "%tempDir%\vita3k.zip"
MKDIR "%systemsDir%\Vita3k"
%toolsDir%\7za\7za.exe x "%tempDir%\vita3k.zip" -o"%systemsDir%\Vita3k" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\vita3k.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Xemu
GOTO completed
::==============================================
::==============================================
:Xemu
::Installs Xemu (XBOX Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING XEMU
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/mborgerson/xemu/releases/latest/download/xemu-win-release.zip -O "%tempDir%\xemu.zip"
MKDIR "%systemsDir%\Xemu"
%toolsDir%\7za\7za.exe x "%tempDir%\xemu.zip" -o"%systemsDir%\Xemu" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\xemu.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Xenia
GOTO completed
::==============================================
::==============================================
:Xenia
::Installs xenia (XBOX 360 Emulator) 
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING XENIA
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/xenia-project/release-builds-windows/releases/latest/download/xenia_master.zip -O "%tempDir%\xenia.zip"
MKDIR "%systemsDir%\Xenia"
%toolsDir%\7za\7za.exe x "%tempDir%\xenia.zip" -o"%systemsDir%\Xenia" -aoa >NUL
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\xenia.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO XRoar
GOTO completed
::==============================================
::==============================================
:XRoar
::Installs Xroar (Dragon and CoCo Emulator)
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO XROAR64
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO XROAR32
	)
::==============================================
:XROAR32
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING XROAR 32bit
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://www.6809.org.uk/xroar/dl/xroar-1.0.9-w32.zip -O "%tempDir%\XRoar32.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\XRoar32.zip" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\xroar-1.0.9-w32" XRoar
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\XRoar32.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Yuzu
GOTO completed
::==============================================
:XROAR64
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING XROAR 64bit
echo =================================================================
%toolsDir%\Wget\wget.exe -q http://www.6809.org.uk/xroar/dl/xroar-1.0.9-w64.zip -O "%tempDir%\XRoar64.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\XRoar64.zip" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\xroar-1.0.9-w64" XRoar
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\XRoar64.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Yuzu
GOTO completed
::==============================================
::==============================================
:Yuzu
::Installs Yuzu (Switch Development Emulator)
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING YUZU
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://github.com/yuzu-emu/yuzu-mainline/releases/download/mainline-0-963/yuzu-windows-msvc-20220325-15bf148da.zip -O "%tempDir%\yuzu.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\yuzu.zip" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\yuzu-windows-msvc" Yuzu
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\yuzu.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO VICE
GOTO completed
::==============================================
::==============================================
:VICE
::Installs VICE (Commodore 64 Emulator)
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO VICE64
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO VICE32
	)
::==============================================
:VICE32
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING VICE                        
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://sourceforge.net/projects/vice-emu/files/releases/binaries/windows/GTK3VICE-3.6.1-win32.zip/download -O "%tempDir%\VICE32.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\VICE32.zip" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\GTK3VICE-3.6.1-win32" WinVICE
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\VICE32.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Selection4_tmpClean
GOTO completed
::==============================================
:VICE64
CLS
echo =
echo =
echo =
echo =
echo =================================================================
echo =    DOWNLOADING VICE                        
echo =================================================================
%toolsDir%\Wget\wget.exe -q https://sourceforge.net/projects/vice-emu/files/releases/binaries/windows/GTK3VICE-3.6.1-win64.zip/download -O "%tempDir%\VICE64.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\VICE64.zip" -o"%systemsDir%" -aoa >NUL
ping 127.0.0.1 -n 2 >NUL
CD /D "%systemsDir%"
REN "%systemsDir%\GTK3VICE-3.6.1-win64" WinVICE
echo =
echo =
echo =
echo =
echo ================================================
echo =    Cleaning up downloaded file(s)        
echo ================================================
ping 127.0.0.1 -n 2 >NUL
DEL "%tempDir%\VICE64.zip"
IF EXIST "%systemsDir%\tmp.txt" GOTO Selection4_tmpClean
GOTO completed
::==============================================
::==============================================
:Selection4_tmpClean
::Cleans up temp files created by the automated installers.
IF EXIST "%systemsDir%\tmp.txt" DEL "%systemsDir%\tmp.txt"
IF EXIST "%tempDir%\BrandNewBlank" GOTO Selection4_DediAsk
IF EXIST "%tempDir%\BrandNewDef" GOTO Selection4_DediAsk
IF EXIST "%tempDir%\BrandNewCus" GOTO Selection4_DediAsk
GOTO completed
::==============================================
:Selection4_DediAsk
::Asks if this machine will be used as a dedicated emulator machine instead of installing as an application.
CLS
::
::Add a description of what happens for dedi yes answer!!!!!!!
::
SET /P c=Is this system a dedicated Emulator Box [Y/N]?
IF /I "%c%" EQU "Y" GOTO Selection6_FullDedi
IF /I "%c%" EQU "N" GOTO Selection4_BrandNewClean
::==============================================
:Selection4_BrandNewClean
::Removes temporary files used for guiding installation.
CLS
DEL "%tempDir%\BrandNewBlank"
DEL "%tempDir%\BrandNewDef"
DEL "%tempDir%\BrandNewCus"
GOTO completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection5
::Menu for managing ROM directories in both windows and es_systems.cfg. Can also share your ROM directories.
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Manage ROM Directories             
echo ===========================================
echo =    1.) CREATE DEFAULT ROM DIRECTORIES (%romsDir%\SYSTEMNAME)
echo =    2.) CREATE CUSTOM ROM DIRECTORIES
echo =    3.) SHARE ROM DIRECTORY
echo -------------------------------------------
echo =    4.) OPEN ROMS FOLDER
echo -------------------------------------------
echo =    5.) RETURN TO MAIN MENU
echo ===========================================
echo =
CHOICE /C 12345 /N /T 60 /D 5 /M "=->  Enter selection (1,2,3,4,5): "
IF ERRORLEVEL ==5 GOTO Main
IF ERRORLEVEL ==4 GOTO Selection5_OpenROMSNow
IF ERRORLEVEL ==3 GOTO DediShare
IF ERRORLEVEL ==2 GOTO Selection5_CusRomDirSet
IF ERRORLEVEL ==1 GOTO Selection5_DefaultRomFolders
GOTO crash
::==============================================
::==============================================
:Selection5_DefaultRomFolders
::Creates default ROM folders in RP4Win\EmulationStation\.emulationstation\roms
CLS
MKDIR %romsDir%\3do
MKDIR %romsDir%\ags
MKDIR %romsDir%\amiga
MKDIR %romsDir%\amstradcpc
MKDIR %romsDir%\apple2
MKDIR %romsDir%\atari2600
MKDIR %romsDir%\atari5200
MKDIR %romsDir%\atari7800
MKDIR %romsDir%\atari800
MKDIR %romsDir%\atarijaguar
MKDIR %romsDir%\atarilynx
MKDIR %romsDir%\atarist
MKDIR %romsDir%\bbcmicro
MKDIR %romsDir%\c64
MKDIR %romsDir%\coco
MKDIR %romsDir%\colecovision
MKDIR %romsDir%\daphne
MKDIR %romsDir%\dragon32
MKDIR %romsDir%\dreamcast
MKDIR %romsDir%\fba
MKDIR %romsDir%\fds
MKDIR %romsDir%\gameandwatch
MKDIR %romsDir%\gamegear
MKDIR %romsDir%\gb
MKDIR %romsDir%\gba
MKDIR %romsDir%\gbc
MKDIR %romsDir%\gc
MKDIR %romsDir%\intellivision
MKDIR %romsDir%\mame
MKDIR %romsDir%\mastersystem
MKDIR %romsDir%\mega32x
MKDIR %romsDir%\mega-cd
MKDIR %romsDir%\megadrive
MKDIR %romsDir%\msx
MKDIR %romsDir%\mvs
MKDIR %romsDir%\n64
MKDIR %romsDir%\nds
MKDIR %romsDir%\neogeo
MKDIR %romsDir%\nes
MKDIR %romsDir%\ngp
MKDIR %romsDir%\ngpc
MKDIR %romsDir%\pcengine
MKDIR %romsDir%\ps2
MKDIR %romsDir%\psp
MKDIR %romsDir%\psx
MKDIR %romsDir%\saturn
MKDIR %romsDir%\sega32x
MKDIR %romsDir%\segacd
MKDIR %romsDir%\sfc
MKDIR %romsDir%\sg-1000
MKDIR %romsDir%\snes
MKDIR %romsDir%\vectrex
MKDIR %romsDir%\virtualboy
MKDIR %romsDir%\wii
MKDIR %romsDir%\wiiu
MKDIR %romsDir%\zxspectrum
:: Opens file location
START %romsDir%
IF EXIST "%tempDir%\BrandNewDef" GOTO Selection3_updateRA
GOTO completed
::==============================================
::==============================================
:Selection5_CusRomDirSet
::Prompts to enter the custom installation path.
CLS
COLOR 07
echo =
echo =
echo =
echo =
echo ===========================================
echo =    CUSTOM ROM DIRECTORY            
echo ===========================================
echo =
echo =    Enter the path you wish to use for ROMS.
echo = 
echo =    Examples: D:\ROMS, E:\Game\roms, F:\.emulationstation\roms
echo = 
echo =    Press enter when finished. and please double check the path.
echo =    (default %romsDir%)
echo =    (custom %cusromdir%)
echo =
::Sets Custom ROM Directory via user input
SET /P cusromdir="=->  Enter Path for ROM Folder: "
IF /I "%cusromdir%" EQU "Q" GOTO Quit
IF %cusromdir% == "%romsDir%" || %cusromdir% == "%romsDir%\" (
    SET erorr=Selection5_CusRomDirSet
	GOTO InvalidInput
) else (
	GOTO CusRomPathCheck
)
GOTO NoFeat
:writeRomDir
::writes the directory to %APPDATA%\RP4Win\ for use when launching the bat file.
IF NOT EXIST %APPDATA%\RP4Win\ MKDIR "%APPDATA%\RP4Win"
IF EXIST "%APPDATA%\RP4Win\CusRomDir.txt" DEL "%APPDATA%\RP4Win\CusRomDir.txt"
::removes trailing space
SET cusromdir=%cusromdir:~0,-1%
echo %cusromdir%>%APPDATA%\RP4Win\CusRomDir.txt
GOTO Selection5_CustomRomFolders

:PullRomDir
::Pulls the directory string from a custom install text file.
SET /P cusromdir=<%APPDATA%\RP4Win\CusRomDir.txt
GOTO CheckRP4Win

:CusRomPathCheck
::Checks dummy file in AppData for a custom install directory.
IF EXIST %APPDATA%\RP4Win\CusRomDir.txt GOTO DelRomDir
GOTO writeRomDir

:DelRomDir
DEL %APPDATA%\RP4Win\CusRomDir.txt
GOTO writeRomDir
::==============================================
:Selection5_CustomRomFolders
::Creates ROM folders based on variable set by user above
CLS
MKDIR %cusromdir%\3do
MKDIR %cusromdir%\ags
MKDIR %cusromdir%\amiga
MKDIR %cusromdir%\amstradcpc
MKDIR %cusromdir%\apple2
MKDIR %cusromdir%\atari2600
MKDIR %cusromdir%\atari5200
MKDIR %cusromdir%\atari7800
MKDIR %cusromdir%\atari800
MKDIR %cusromdir%\atarijaguar
MKDIR %cusromdir%\atarilynx
MKDIR %cusromdir%\atarist
MKDIR %cusromdir%\bbcmicro
MKDIR %cusromdir%\c64
MKDIR %cusromdir%\coco
MKDIR %cusromdir%\colecovision
MKDIR %cusromdir%\daphne
MKDIR %cusromdir%\dragon32
MKDIR %cusromdir%\dreamcast
MKDIR %cusromdir%\fba
MKDIR %cusromdir%\fds
MKDIR %cusromdir%\gameandwatch
MKDIR %cusromdir%\gamegear
MKDIR %cusromdir%\gb
MKDIR %cusromdir%\gba
MKDIR %cusromdir%\gbc
MKDIR %cusromdir%\gc
MKDIR %cusromdir%\intellivision
MKDIR %cusromdir%\mame
MKDIR %cusromdir%\mastersystem
MKDIR %cusromdir%\mega32x
MKDIR %cusromdir%\mega-cd
MKDIR %cusromdir%\megadrive
MKDIR %cusromdir%\msx
MKDIR %cusromdir%\mvs
MKDIR %cusromdir%\n64
MKDIR %cusromdir%\nds
MKDIR %cusromdir%\neogeo
MKDIR %cusromdir%\nes
MKDIR %cusromdir%\ngp
MKDIR %cusromdir%\ngpc
MKDIR %cusromdir%\pcengine
MKDIR %cusromdir%\ps2
MKDIR %cusromdir%\psp
MKDIR %cusromdir%\psx
MKDIR %cusromdir%\saturn
MKDIR %cusromdir%\sega32x
MKDIR %cusromdir%\segacd
MKDIR %cusromdir%\sfc
MKDIR %cusromdir%\sg-1000
MKDIR %cusromdir%\snes
MKDIR %cusromdir%\vectrex
MKDIR %cusromdir%\virtualboy
MKDIR %cusromdir%\wii
MKDIR %cusromdir%\wiiu
MKDIR %cusromdir%\zxspectrum
:: Opens file location
START %cusromdir%
IF EXIST "%tempDir%\BrandNewCus" GOTO Selection3_updateRA
GOTO completed
::==============================================
:Selection5_OpenROMSNow
START %romsDir%
GOTO Selection5
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection6
::Menu for dedicated EmuBox Options/installation. Used for setting the machine to be installed as a standalone emulator box and not just an application
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    Manage Dedicated Emubox Settings             
echo ===========================================
echo =    1.) SETUP ALL DEDICATED EMUBOX SETTINGS
echo =    (Auto Start, Auto Login, Folder Shares, System Name to RP4Win)
echo -------------------------------------------
echo =    2.) RP4Win AUTO START OPTIONS
echo -------------------------------------------
echo =    3.) SETUP AUTOLOGIN
echo -------------------------------------------
echo =    4.) SETUP RP4Win FOLDER SHARES
echo -------------------------------------------
echo =    5.) SETUP SYSTEM NAME
echo -------------------------------------------
echo =    6.) RETURN TO MAIN MENU
echo ===========================================
echo =
CHOICE /C 123456 /N /T 30 /D 6 /M "=->  Enter selection (1,2,3,4,5,6): "
IF ERRORLEVEL ==6 GOTO Main
IF ERRORLEVEL ==5 GOTO Selection6_DediHostnameMenu
IF ERRORLEVEL ==4 GOTO Selection6_DediShareMenu
IF ERRORLEVEL ==3 GOTO Selection6_AutoLogin
IF ERRORLEVEL ==2 GOTO Selection6_AutoStartMenu
IF ERRORLEVEL ==1 GOTO Selection6_FullDedi
GOTO crash
::==============================================
::==============================================
:Selection6_FullDedi
::Creates a temporary file to guide the installation process through full dedicated setup.
CLS
echo This file is temporary, you should never see it>"%tempDir%\FullDedi.txt"
IF EXIST "%tempDir%\FullDedi.txt" GOTO Selection6_DediAutoStartSetup
GOTO crash
::==============================================
::==============================================
:Selection6_AutoStartMenu
::Menu for selecting if EmulationStation starts up when the PC logs in.
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    RP4Win AUTO START OPTIONS             
echo ===========================================
echo =    1.) SETUP AUTOMATIC RP4Win LAUNCH ON LOGIN
echo -------------------------------------------
echo =    2.) REMOVE AUTOMATIC RP4Win LAUNCH ON LOGIN
echo -------------------------------------------
echo =    3.) RETURN TO DEDICATED EMUBOX MENU
echo ===========================================
echo =
CHOICE /C 123 /N /T 30 /D 3 /M "=->  Enter selection (1,2,3): "
IF ERRORLEVEL ==3 GOTO Selection6
IF ERRORLEVEL ==2 GOTO Selection6_DediAutoStartRemove
IF ERRORLEVEL ==1 GOTO Selection6_DediAutoStartSetup
GOTO crash
::==============================================
::==============================================
:Selection6_DediAutoStartSetup
::Creates a batch file to launch EmulationStation. Creates a shortcut in the startup folder.
CLS
echo =
echo =
echo =
echo =
echo ====================================================
echo =    ADDING RP4Win TO AUTOSTART ON LOGIN         
echo ====================================================
echo taskkill /im explorer.exe /f>"%toolsDir%\startES.bat"
echo %esDir%\emulationstation.exe>>"%toolsDir%\startES.bat"
CD /D "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
DEL "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startES.lnk"
echo Set oWS = WScript.CreateObject("WScript.Shell")>"%tempDir%\CreateShortcut0.vbs"
echo sLinkFile = "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startES.lnk">>"%tempDir%\CreateShortcut0.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile)>>"%tempDir%\CreateShortcut0.vbs"
echo oLink.TargetPath = "%toolsDir%\startES.bat">>"%tempDir%\CreateShortcut0.vbs"
echo oLink.WorkingDirectory = "%toolsDir%">>"%tempDir%\CreateShortcut0.vbs"
echo oLink.IconLocation = "%esDir%\emulationstation.exe">>"%tempDir%\CreateShortcut0.vbs"
echo oLink.Save>>"%tempDir%\CreateShortcut0.vbs"
CSCRIPT "%tempDir%\CreateShortcut0.vbs"
DEL "%tempDir%\CreateShortcut0.vbs"
IF EXIST "%tempDir%\FullDedi.txt" GOTO Selection6_AutoLogin
GOTO completed
::==============================================
:Selection6_DediAutoStartRemove
::Removes the shortcut in the startup folder. Disabling launching emulationstation on login.
CLS
echo =
echo =
echo =
echo =
echo ====================================================
echo =    REMOVING RP4Win AUTOSTART ON LOGIN       
echo ====================================================
DEL "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startES.lnk"
DEL "%toolsDir%\startES.bat"
GOTO completed
::==============================================
::==============================================
:Selection6_AutoLogin
::Guides the user through setting up Auto login. Tried to do this via registry edits, but it never worked properly.
CLS
echo =
echo =
echo =
echo =
echo ==================================================================
echo =                                                                
echo =    PLEASE UNCHECK THE BOX LABELLED                
echo =
echo =    "Users must enter a user name and password to use this computer" 
echo =
echo =    THEN PRESS OK OR APPLY                    
echo =                                                                
echo =    PRESS ANY KEY WHEN FINISHED                   
echo =                                                                
echo ==================================================================
START netplwiz
PAUSE >NUL
IF EXIST "%tempDir%\FullDedi.txt" GOTO Selection6_DediShare
GOTO completed
::==============================================
::==============================================
:Selection6_DediShareMenu
::Menu for Managing sharing of the RP4Win folders (ROMS, emulationstation config folder, RetroArch, and additional emulators.)
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    SETUP RP4Win FOLDER SHARES             
echo ===========================================
echo =    1.) SETUP RP4Win SHARES WITH ROM DIRECTORY
echo -------------------------------------------
echo =    2.) REMOVE RP4Win SHARES
echo -------------------------------------------
echo =    3.) RETURN TO DEDICATED EMUBOX MENU
echo ===========================================
echo =
CHOICE /C 123 /N /T 30 /D 3 /M "=->  Enter selection (1,2,3): "
IF ERRORLEVEL ==3 GOTO Selection6
IF ERRORLEVEL ==2 GOTO Selection6_DediRemoveShares
IF ERRORLEVEL ==1 GOTO Selection6_DediShare
GOTO crash
::==============================================
::==============================================
:Selection6_DediShare
::Shares all folders and sets permissions to Everyone R/W. Moves to ROM shares and checks if they are default or custom.
CLS
net share BIOS=%RADir%\system /grant:everyone,full
net share Emulationstation="%USERPROFILE%\.emulationstation" /grant:everyone,full
net share Emulators=%systemsDir% /grant:everyone,full
IF EXIST %romsDir%\ GOTO Selection6_RomShareDef
GOTO Selection6_RomShareCus
::==============================================
:Selection6_RomShareDef
::Shares default ROM dir.
net share ROMS=%romsDir% /grant:everyone,full
IF EXIST "%tempDir%\FullDedi.txt" GOTO Selection6_DediHostnameDef
GOTO completed
::==============================================
:Selection6_RomShareCus
::Shares Custom ROM dir.

SET /p cusromdir="Enter Path for ROM Folder (default %romsDir%): "
net share ROMS=%cusromdir% /grant:everyone,full
IF EXIST "%tempDir%\FullDedi.txt" GOTO Selection6_DediHostnameDef
GOTO completed
::==============================================
:Selection6_DediRemoveShares
::Removes the shares created by this installer.
CLS
net share BIOS /delete
net share EmulationStation /delete
net share Emulators /delete
net share ROMS /delete
GOTO completed
::==============================================
:Selection6_DediHostnameMenu
::Menu for managing the PC's hostname
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    SETUP SYSTEM NAME             
echo ===========================================
echo =
echo =    1.) CHANGE PC NAME TO "RP4Win"
echo =
echo -------------------------------------------
echo =
echo =    2.) CHANGE PC NAME TO CUSTOM PC NAME
echo =
echo -------------------------------------------
echo =
echo =    3.) RETURN TO DEDICATED EMUBOX MENU
echo =
echo ===========================================
echo =
CHOICE /C:123 /N /T 30 /D 3 /M "=->  Enter selection (1,2,3): "
IF ERRORLEVEL ==3 GOTO Selection6
IF ERRORLEVEL ==2 GOTO Selection6_DediHostnameCus
IF ERRORLEVEL ==1 GOTO Selection6_DediHostnameDef
GOTO crash
::==============================================
:Selection6_DediHostnameDef
::Sets the hostname to RP4Win.
WMIC computersystem where caption='%COMPUTERNAME%' rename RP4Win
IF EXIST "%tempDir%\FullDedi.txt" GOTO Selection6_FullDediClean
GOTO completed
::==============================================
:Selection6_DediHostnameCus
::Allows the setting of custom hostname.
CLS
SET /p cushostname="Enter custom PC name: "
WMIC computersystem where caption='%COMPUTERNAME%' rename %cushostname%
GOTO completed
::==============================================
:Selection6_FullDediClean
::Removes the temporary file used for performing all dedicated installation options.
IF EXIST "%tempDir%\FullDedi.txt" DEL "%tempDir%\FullDedi.txt"
GOTO completed
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection7
::Menu for cleaning stuff. Mostly just for me when debugging stuff and I need to uninstall and reinstall multiple times.
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo =    System Cleanup             
echo ===========================================
echo =
echo =    1.) REMOVE ALL RP4Win FILES
echo =
echo -------------------------------------------
echo =
echo =    2.) REMOVE EMULATIONSTATION AND PREFERENCES
echo =
echo =    3.) REMOVE RETROARCH AND PREFERENCES
echo =
echo =    4.) REMOVE ADDITIONAL EMULATORS AND PREFERENCES
echo =
echo =    5.) REMOVE RP4Win TOOLS (GIT AND 7ZA)
echo =
echo -------------------------------------------
echo =
echo =    6.) EXIT TO MAIN MENU
echo =
echo ===========================================
echo =
CHOICE /C:123456 /N /T 30 /D 6 /M "=->  Enter selection (1,2,3,4,5,6): "
IF ERRORLEVEL ==6 GOTO Main
IF ERRORLEVEL ==5 GOTO Selection7_CleanTools
IF ERRORLEVEL ==4 GOTO Selection7_CleanEmu
IF ERRORLEVEL ==3 GOTO Selection7_CleanRA
IF ERRORLEVEL ==2 GOTO Selection7_CleanES
IF ERRORLEVEL ==1 GOTO Selection7_CleanAll
GOTO crash
::==============================================
:Selection7_CleanAll
::Prompts confirmation before wiping out all files.
CLS
SET /P c=Are you sure you want to delete ALL RP4Win Files (Tries to move roms from %romsDir% to %USERPROFILE%\ROMS, but backup roms just to be safe before proceeding!)[Y/N]?
IF /I "%c%" EQU "Y" GOTO Selection7_delall
IF /I "%c%" EQU "N" GOTO Main
GOTO Selection7
::==============================================
:Selection7_delall
::Deletes any and all files used or created by RP4Win. Moves any ROMS found in the RP4Win directory to %USERPROFILE%\ROMS as to not wipe out your collection. does not remove ROMS in custom directories.
CLS
echo =
echo =
echo =
echo =
echo =====================================================
echo =                                                   
echo =    DELETING ALL RETROARCH AND EMULATIONSTATION FILES 
echo =                                                   
echo =====================================================
CD /D "%rp4winDir:~0,-6%"
IF EXIST %romsDir%\ MOVE "%romsDir%" "%USERPROFILE%\ROMS"
IF EXIST "%USERPROFILE%\Desktop\RP4Win.lnk" DEL "%USERPROFILE%\Desktop\RP4Win.lnk"
IF EXIST "%USERPROFILE%\Desktop\RP4Win Windowed.lnk" DEL "%USERPROFILE%\Desktop\RP4Win Windowed.lnk"
IF EXIST "%rp4winDir%\RP4Win.lnk" DEL "%rp4winDir%\RP4Win.lnk"
IF EXIST "%rp4winDir%\RP4Win Windowed.lnk" DEL "%rp4winDir%\RP4Win Windowed.lnk"
IF EXIST "%APPDATA%\RP4Win\CusInstallDir.txt" DEL "%APPDATA%\RP4Win\CusInstallDir.txt"
IF EXIST %USERPROFILE%\.emulationstation\ RMDIR "%USERPROFILE%\.emulationstation" /S /Q
IF EXIST %rp4winDir%\EmulationStation\ RMDIR "%rp4winDir%\EmulationStation" /S /Q
IF EXIST %rp4winDir%\RetroArch\ RMDIR "%rp4winDir%\RetroArch" /S /Q
IF EXIST %rp4winDir%\Backup\ RMDIR "%rp4winDir%\Backup" /S /Q
IF EXIST %rp4winDir%\Tools\ RMDIR "%rp4winDir%\Tools" /S /Q
IF EXIST %rp4winDir%\Temp\ RMDIR "%rp4winDir%\Temp" /S /Q
GOTO Selection7_CleanAllExit
::==============================================
:Selection7_CleanES
::Prompts for the deletion of all EmulationStation and related files
CLS
SET /P c=Are you sure you want to delete ALL EmulationStation Files (Includes Settings)[Y/N]?
IF /I "%c%" EQU "Y" GOTO Selection7_delES
IF /I "%c%" EQU "N" GOTO Main
GOTO Selection7
::==============================================
:Selection7_delES
::Deletes all emulationstation files.
CLS
echo =
echo =
echo =
echo =
echo =====================================================
echo =                                                   
echo =    DELETING EMULATIONSTATION FILES          
echo =                                                   
echo =====================================================
IF EXIST "%USERPROFILE%\Desktop\RP4Win.lnk" DEL "%USERPROFILE%\Desktop\RP4Win.lnk"
IF EXIST "%USERPROFILE%\Desktop\RP4Win Windowed.lnk" DEL "%USERPROFILE%\Desktop\RP4Win Windowed.lnk"
IF EXIST "%rp4winDir%\RP4Win.lnk" DEL "%rp4winDir%\RP4Win.lnk"
IF EXIST "%rp4winDir%\RP4Win Windowed.lnk" DEL "%rp4winDir%\RP4Win Windowed.lnk"
RMDIR "%esDir%" /S /Q
RMDIR "%USERPROFILE%\.emulationstation" /S /Q
GOTO Selection7_CleanAllExit
::==============================================
:Selection7_CleanRA
::Prompts for the deletion of all RetroArch and related files
CLS
SET /P c=Are you sure you want to delete ALL RetroArch Files (Includes Settings)[Y/N]?
IF /I "%c%" EQU "Y" GOTO Selection7_delRA
IF /I "%c%" EQU "N" GOTO Main
GOTO Selection7
::==============================================
:Selection7_delRA
::Deletes all RetroArch and related files
CLS
echo =
echo =
echo =
echo =
echo =====================================================
echo =                                                   
echo =    DELETING RETROARCH FILES              
echo =                                                   
echo =====================================================
RMDIR "%RADir%" /S /Q
GOTO Selection7_CleanAllExit
::==============================================
:Selection7_CleanEmu
::Prompts for the deletion of all additional emulators and related files
CLS
SET /P c=Are you sure you want to delete ALL Additional Emulators (Includes Settings)[Y/N]?
IF /I "%c%" EQU "Y" GOTO Selection7_delEmu
IF /I "%c%" EQU "N" GOTO Main
GOTO Selection7
::==============================================
:Selection7_delEmu
::Deletes all additional emulators.
CLS
echo =
echo =
echo =
echo =
echo =====================================================
echo =                                                   
echo =    DELETING ADDITIONAL EMULATORS FILES        
echo =                                                   
echo =====================================================
RMDIR "%systemsDir%" /S /Q
GOTO Selection7_CleanAllExit
::==============================================
:Selection7_CleanTools
::Prompts for the deletion of RP4Win's support tools (7za, git, etc)
CLS
SET /P c=Are you sure you want to delete ALL RP4Win tools (Includes Settings)[Y/N]?
IF /I "%c%" EQU "Y" GOTO Selection7_delTools
IF /I "%c%" EQU "N" GOTO Main
GOTO Selection7
::==============================================
:Selection7_delTools
::Deletes all tools used by RP4Win (Relaunching the batch file will redownload and install them.
CLS
echo =
echo =
echo =
echo =
echo =====================================================
echo =                                                   
echo =    DELETING RP4Win TOOLS              
echo =                                                   
echo =====================================================
RMDIR "%toolsDir%" /S /Q
GOTO Selection7_CleanAllExit
::==============================================
::==============================================
:Selection7_CleanAllExit
::Lets you know all files are removed. exits the bat file.
CLS
COLOR 0F
echo =
echo =
echo =
echo =
echo ===========================================
echo -------------------------------------------
echo CLEANUP COMPLETE, PLEASE RESTART RP4Win.BAT
echo IF YOU REMOVED ANYTHING IN: %romsDir%
echo THEY ARE NOW IN C:\ROMS
echo -------------------------------------------
echo ===========================================
echo =          Press Any Key to Exit
PAUSE >NUL
CLS
EXIT /B 0
::==============================================
::==============================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
:Selection9
::Creates a batch file to pull the latest RP4Win.bat. Launches the new batch file that launches the new RP4Win.bat. Needed this separation as launching from inside this RP4Win.bat caused crashing issues.
CLS
echo PLEASE WAIT...
IF EXIST "%toolsDir%\Updater.bat" DEL "%toolsDir%\Updater.bat"
echo @ECHO OFF >"%toolsDir%\Updater.bat"
echo TIMEOUT /T 5 >>"%toolsDir%\Updater.bat"
echo IF EXIST "%rp4winDir%\RP4Win.bat" DEL "%rp4winDir%\RP4Win.bat" >>"%toolsDir%\Updater.bat"
echo %toolsDir%\git\bin\git.exe clone --depth=1 https://github.com/ironmine86/RP4Win.git %tempDir%\Script >>"%toolsDir%\Updater.bat"
echo XCOPY %tempDir%\Script\RP4Win.bat %rp4winDir%\ >>"%toolsDir%\Updater.bat"
echo RMDIR "%tempDir%\Script" /S /Q >>"%toolsDir%\Updater.bat"
echo START /MAX cmd.exe /c "%rp4winDir%\RP4Win.bat" >>"%toolsDir%\Updater.bat"
echo EXIT /B 0 >>"%toolsDir%\Updater.bat"
TIMEOUT /T 5
::START /MAX cmd.exe /c "%toolsDir%\Updater.bat" max & EXIT /B 0
GOTO Main
::==============================================
::=================================================================================================================================================================================================================================================================================================================








::=================================================================================================================================================================================================================================================================================================================
::=================================================================================================================================================================================================================================================================================================================

::=================================================================================================================================================================================================================================================================================================================
::=================================================================================================================================================================================================================================================================================================================
::=================================================================================================================================================================================================================================================================================================================
::=================================================================================================================================================================================================================================================================================================================
::=================================================================================================================================================================================================================================================================================================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================
::Rom Scraper
::==============================================
:Selection8
GOTO Disabled
IF EXIST %toolsDir%\scraper.exe GOTO ScraperMenu
GOTO ScraperArch

:ScraperArch
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
		GOTO ScraperDL64
	)
IF "%PROCESSOR_ARCHITECTURE%"=="x86" (
		GOTO ScraperDL86
	)
	
:ScraperDL86
%toolsDir%\Wget\wget.exe -q https://github.com/sselph/scraper/releases/download/v1.4.6/scraper_windows_386.zip -O "%tempDir%\scraperx86.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\scraperx86.zip" -o"%toolsDir%" -aoa >NUL
GOTO ScraperMenu

:ScraperDL64
%toolsDir%\Wget\wget.exe -q https://github.com/sselph/scraper/releases/download/v1.4.6/scraper_windows_amd64.zip -O "%tempDir%\scraperx64.zip"
%toolsDir%\7za\7za.exe x "%tempDir%\scraperx64.zip" -o"%toolsDir%" -aoa >NUL
GOTO ScraperMenu

:ScraperMenu
::Currently Disabled as SSelph's scraper no longer works.
CLS
echo =
echo =
echo =
echo =
echo ===========================================
echo               Rom Scraper             
echo ===========================================
echo **1.) SCRAPE ALL ROMS
echo -------------------------------------------
echo **2.) SCRAPE INDIVIDUAL SYSTEMS
echo -------------------------------------------
echo **3.) RETURN TO MAIN MENU
echo ===========================================
echo =
CHOICE /C:123 /N /T 30 /D 3 /M "=->  Enter selection (1,2,3): "
IF ERRORLEVEL ==3 GOTO Main
IF ERRORLEVEL ==2 GOTO ScraperSysMenu
IF ERRORLEVEL ==1 GOTO ScrapeAll
GOTO crash
:ScrapeAll
%toolsDir%\scraper.exe -scrape_all
GOTO completed
:ScraperSysMenu
CLS
echo =
echo =
echo =
echo =
echo ===========================================================================
echo =                                                                         =
echo =    1.) NINTENDO                                                         =
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
echo =
CHOICE /N /C:12345 /M "=->  Enter selection (1,2,3,4,5): "
IF ERRORLEVEL ==5 GOTO ScraperMenu
IF ERRORLEVEL ==4 GOTO OtherScrapeList
IF ERRORLEVEL ==3 GOTO SonyScrapeList
IF ERRORLEVEL ==2 GOTO SegaScrapeList
IF ERRORLEVEL ==1 GOTO NintendoScrapeList
GOTO crash

:NintendoScrapeList
CLS
echo =
echo =
echo =
echo =
echo ===========================================================================
echo =                                                                         =
echo =    1.) CONSOLE                                                          =
echo =                                                                         =
echo =    2.) PORTABLE                                                         =
echo =                                                                         =
echo =                                                                         =
echo =    3.) RETURN TO PREVIOUS MENU                                          =
echo =                                                                         =
echo ===========================================================================
echo =
CHOICE /N /C:123 /M "=->  Enter selection (1,2,3): "
IF ERRORLEVEL ==3 GOTO ScraperSysMenu
IF ERRORLEVEL ==2 GOTO NintendoScrapeListPortable
IF ERRORLEVEL ==1 GOTO NintendoScrapeListConsole
GOTO crash

:NintendoScrapeListConsole
CLS
echo =
echo =
echo =
echo =
echo ===========================================================================
echo =                                                                         =
echo =    1.) NES                                                              =
echo =    2.) FAMICOM DISK SYSTEM                                              =
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
echo =
CHOICE /N /C:123456789 /M "=->  Enter selection (1,2,3,4,5,6,7,8,9): "
IF ERRORLEVEL ==9 GOTO NintendoScrapeList
IF ERRORLEVEL ==8 GOTO NoFeat
IF ERRORLEVEL ==7 GOTO NoFeat
IF ERRORLEVEL ==6 GOTO GCScrape
IF ERRORLEVEL ==5 GOTO N64Scrape
IF ERRORLEVEL ==4 GOTO VBOYScrape
IF ERRORLEVEL ==3 GOTO SNESScrape
IF ERRORLEVEL ==2 GOTO FDSScrape
IF ERRORLEVEL ==1 GOTO NesScrape
GOTO crash


:NintendoScrapeListPortable
CLS
echo =
echo =
echo =
echo =
echo ===========================================================================
echo =                                                                         =
echo =    1.) GAMEBOY                                                          =
echo =    2.) GAMEBOY COLOR                                                    =
echo =    3.) GAMEBOY ADVANCE                                                  =
echo =    4.) NINTENDO DS                                                      =
echo =    5.) NINTENDO 3DS                                                     =
echo =    6.) NINTENDO Switch                                                  =
echo =                                                                         =
echo =    7.) RETURN TO PREVIOUS MENU                                          =
echo =                                                                         =
echo ===========================================================================
echo =
CHOICE /N /C:1234567 /M "=->  Enter selection (1,2,3,4,5,6,7): "
IF ERRORLEVEL ==7 GOTO NintendoScrapeList
IF ERRORLEVEL ==6 GOTO NoFeat
IF ERRORLEVEL ==5 GOTO 3DSScrape
IF ERRORLEVEL ==4 GOTO DSScrape
IF ERRORLEVEL ==3 GOTO GBAScrape
IF ERRORLEVEL ==2 GOTO GBCScrape
IF ERRORLEVEL ==1 GOTO GBScrape
GOTO crash


:SegaScrapeList
GOTO NoFeat 


:SonyScrapeList
GOTO NoFeat


:OtherScrapeList
GOTO NoFeat


::=================================================================================================================================================================================================================================================================================================================
::=================================================================================================================================================================================================================================================================================================================
::==============================================