@echo off

rem ############################################################
rem 
rem # This file can only be used to run Asset Build Environment.
rem  
rem ############################################################

set BUILD_HOME_DIR=C:/SoftwareAG1011Designer/common/AssetBuildEnvironment

call %BUILD_HOME_DIR%/../../install/bin/setenv.bat 

set ANT_HOME=%BUILD_HOME_DIR%/../lib/ant

if "%ANT_HOME%"=="" (
  echo ANT_HOME is not defined.
  goto end
)

if exist build.properties (%ANT_HOME%/bin/ant -f %BUILD_HOME_DIR%/master_build/build.xml -DpathCWD=%cd% %*) else ( %ANT_HOME%/bin/ant -f %BUILD_HOME_DIR%/master_build/build.xml %*)

:end
