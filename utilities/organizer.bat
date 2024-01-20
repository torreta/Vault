@echo off
setlocal enabledelayedexpansion

REM Check if folder path is provided as an argument
if "%~1"=="" (
    echo Please provide a folder path as an argument.
    exit /b 1
)

set "folder_path=%~1"

REM Check if the provided folder exists
if not exist "%folder_path%" (
    echo The specified folder does not exist.
    exit /b 1
)

REM Check if output file path is provided as an argument
if "%~2"=="" (
    echo Please provide an output file path as the second argument.
    exit /b 1
)

set "output_file=%~2"

REM Clear the output file if it already exists, or create a new one
type nul > "%output_file%"

REM Function to list files recursively
:list_files_recursive
for /r "%folder_path%" %%F in (*) do (
    echo %%F >> "%output_file%"
)

echo File listing completed. The output is saved in: %output_file%

@REM se usa asi:
@REM list_files.bat C:\path\to\folder C:\path\to\output.txt
@REM C:\Users\dead_\Desktop\Code\drotaca
@REM C:\Users\dead_\Desktop\Code\archivos.txt
@REM ejemplo:
@REM organizer.bat  C:\Users\dead_\Desktop\Code\drotaca C:\Users\dead_\Desktop\Code\archivos.txt