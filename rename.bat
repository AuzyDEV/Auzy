@echo off
rem This file was created by pub v2.16.1.
rem Package: rename
rem Version: 2.0.1
rem Executable: rename
rem Script: rename
if exist "C:\Users\ASUS\AppData\Local\Pub\Cache\global_packages\rename\bin\rename.dart-2.16.1.snapshot" (
  call dart "C:\Users\ASUS\AppData\Local\Pub\Cache\global_packages\rename\bin\rename.dart-2.16.1.snapshot" %*
  rem The VM exits with code 253 if the snapshot version is out-of-date.
  rem If it is, we need to delete it and run "pub global" manually.
  if not errorlevel 253 (
    goto error
  )
  dart pub global run rename:rename %*
) else (
  dart pub global run rename:rename %*
)
goto eof
:error
exit /b %errorlevel%
:eof

