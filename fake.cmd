@ECHO OFF

SET TARGET = "help"
IF NOT [%1]==[] (SET TARGET="%1")

ECHO Installing FAKE...
".nuget\nuget" install "FAKE" -Version "1.74.196.0" -ExcludeVersion -OutputDirectory "tools"

ECHO Installing NuGet Packages...
".nuget\nuget" install "packages.config" -ExcludeVersion -OutputDirectory "packages"

ECHO Running Build...
"tools\FAKE\tools\FAKE" "fakefile.fsx" "target=%TARGET%"

EXIT /B %errorlevel%