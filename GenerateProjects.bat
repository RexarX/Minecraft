@echo off
echo Input project generation properties (vs2022, vs2017, ...).
set /p input=
call vendor\bin\premake\premake5.exe %input%
PAUSE