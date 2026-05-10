@echo off
if "%1"=="" goto :NO_ARGS
if "%1"=="clean" goto :CLEAN_ME
goto :ERROR

:NO_ARGS
call :makefile
goto :EOF
:CLEAN_ME
call :CleanFolder
goto :EOF
:ERROR
call :helpme
goto :EOF


:CleanFolder
del /q *.aux 2>nul
del /q *.toc 2>nul
del /q *.log 2>nul
del /q *.out 2>nul
del /q *.bbl 2>nul
del /q *.blg 2>nul
if exist src\*.aux del /q src\*.aux 2>nul
goto :EOF

:makefile
call :CleanFolder
xelatex main.tex  rem generate .toc file
bibtex main
xelatex main.tex rem resolve refs
xelatex main.tex rem generate pdf file
goto :EOF

:helpme
echo Wrong parameter, the usage is:
echo "make" - to make the pdf file
echo "make clean" - to clean the work directory
goto :EOF
