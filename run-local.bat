@echo off
setlocal
cd /d "%~dp0"
where python >nul 2>nul
if errorlevel 1 (
  echo Python 3 was not found. Install Python 3.10+ and enable Add Python to PATH.
  pause
  exit /b 1
)
if not exist ".venv\Scripts\python.exe" (
  echo Creating virtual environment...
  python -m venv .venv
  if errorlevel 1 goto error
)
echo Installing or checking backend dependencies...
".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 goto error
start "Cyber-Pass API" /D "%~dp0" cmd /k ".venv\Scripts\python.exe -m uvicorn api.index:app --host 127.0.0.1 --port 8000"
timeout /t 2 /nobreak >nul
start "Cyber-Pass Website" /D "%~dp0" cmd /k ".venv\Scripts\python.exe -m http.server 5500"
timeout /t 2 /nobreak >nul
start "" http://127.0.0.1:5500
exit /b 0
:error
echo Setup failed. Check the error above and make sure Python/pip can access the internet.
pause
exit /b 1
