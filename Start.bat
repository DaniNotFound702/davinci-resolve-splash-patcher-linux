@echo off
rem Resolve Splash Patcher launcher: checks Python and Pillow, then opens the interface
setlocal
cd /d "%~dp0"

where python >nul 2>nul
if errorlevel 1 (
    echo Python 3.10 or newer is required.
    echo Download it from https://www.python.org/downloads/ and tick "Add python.exe to PATH".
    pause
    exit /b 1
)

python -c "import sys; sys.exit(sys.version_info < (3, 10))" || (
    echo Python 3.10 or newer is required. Update it from https://www.python.org/downloads/
    pause
    exit /b 1
)

python -c "import PIL" 2>nul || (
    echo Installing Pillow...
    python -m pip install --user -r requirements.txt || (echo Failed to install Pillow & pause & exit /b 1)
)

start "" pythonw "%~dp0splash_patcher.py"
