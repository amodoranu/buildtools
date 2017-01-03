@echo off

setlocal ENABLEDELAYEDEXPANSION

set OLDPATH=%PATH%
REM Update the sysenvvar PATH with the paths to the tools that you are going to use (e.g. compiler, cygwin, additional tools)
set PATH=<PATH_TO_TOOLSET_HERE>
%PATH%

set TS_MIRR=<PATH_TO_BUILDTOOLS_HERE>

set TARGET=%2
set NO_OF_JOBS=%1

REM If the number of jobs is undefined, the number of jobs default to 1
if "%TARGET%"=="" (
	set TARGET=rebuild
	bash -c 'echo -n -e "Defaulting to running the [\033[1;31m!TARGET!\033[0m] target ";'

	if "%NO_OF_JOBS%"=="" (
		set NO_OF_JOBS=-j1
		bash -c 'echo -e "with [\033[1;31m!NO_OF_JOBS:-j=!\033[0m] job(s) ...";'		
	) else (
		bash -c 'echo -e "with [\033[1;36m!NO_OF_JOBS:-j=!\033[0m] job(s) ...";'
	)	
) else (
	bash -c 'echo -n -e "Running the [\033[1;36m!TARGET!\033[0m] target ";'
	if "%NO_OF_JOBS%"=="" (
		set NO_OF_JOBS=-j1
		bash -c 'echo -e "with [\033[1;31m!NO_OF_JOBS:-j=!\033[0m] job(s) ...";'		
	) else (
		bash -c 'echo -e "with [\033[1;36m!NO_OF_JOBS:-j=!\033[0m] job(s) ...";'
	)
)

make TS_PATH=%TS_MIRR%/buildtools BUILD_OPT=%CD%/buildopt NO_OF_JOBS=%NO_OF_JOBS% TARGET=%TARGET% %TARGET% -f %TS_MIRR%/buildtools/buildrules

set PATH=%OLDPATH%
endlocal
