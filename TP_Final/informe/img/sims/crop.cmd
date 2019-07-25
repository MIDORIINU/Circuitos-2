@ECHO OFF

for /r %%v in (*.png) do convert -trim "%%v" "%%v"


EXIT /B %ERRORLEVEL%