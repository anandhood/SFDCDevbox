ECHO OFF
REM -- Root Directory --
set rootDir="C:\Anand\GitHub\SFDCDeploy\Deploy\sample"
set repositoryDir="C:\Anand\GitHub\PersonalDev"
echo Repository Directory: %repositoryDir%
cd %rootDir%
set /p relName=Enter branch name:
if "%relName%"=="" GOTO NoReleaseNumber

echo Switch git branch to %relName%
cd %repositoryDir%
call git checkout %relName%

echo Your branch is : %relName%
set /p currentDir="Is this correct branch?"
if NOT "%currentDir%"=="Y" GOTO WrongDir

echo clean workspace %rootDir%\retrieveUnpackaged
cd %rootDir%
cd 
pause
rd /s /q %rootDir%\retrieveUnpackaged

pause
echo run ant script
call ant retrieveUnpackaged

cd
pause
rem echo backing up package.xml
rem move /Y ./package.xml %rootDir%\packagexmlbkp
rem cd ..
rem cd packagexmlbkp
rem ren package.xml package_%date:~10,4%%date:~7,2%%date:~4,2%_%time:~0,2%%time:~3,2%.xml
rem cd ..
rem echo Going to retrivedCode directory
rem cd %rootDir%\retrivedCode
rem dir /s /b > manifest.txt
rem pause
rem cd %rootDir%
rem mkdir Packages\%relName%
rem pause
rem robocopy /S retrivedCode Packages\%relName% /ndl /nfl
rem cd %rootDir%\Packages\%relName%
rem dir /s /b > manifest.txt
rem cd %rootDir%
rem cd
rem mkdir Packages\%relName%
rem pause

rem echo copying retrieveUnpackaged folder to repo ..
rem cd 
rem pause
cd
set /p currentDir="Do you want to copy code to repo?"
if NOT "%currentDir%"=="Y" GOTO ExitScript
del %rootDir%\retrieveUnpackaged\package.xml

pause

echo copying retrieved code to repository..
robocopy /S retrieveUnpackaged %repositoryDir%\src /ndl /nfl

GOTO ExitScript

:NoReleaseNumber
echo No release number entered
cd %rootDir%

:WrongDir
echo Wrong branch

:ExitScript
cd %rootDir%

echo DONE..