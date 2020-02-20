@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"C:\RailsInstaller\Ruby2.3.3\bin\ruby.exe" "D:/xamp/htdocs/Proyectos/Vault/Interview/PagoPrueba/pagoprueba-api/vendor/bundle/bin/rake" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"C:\RailsInstaller\Ruby2.3.3\bin\ruby.exe" "%~dpn0" %*
