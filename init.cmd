@ECHO OFF

REM Prevent multiple initialization within the same command prompt.
IF "%_MSBUILD_INIT%" == "1" (
    ECHO [MSBUILD] Environment already initialized.
    GOTO end
)

SET _MSBUILD_INIT=1

REM The repo root is based off the location of this file.
SET REPOROOT=%~dp0

REM Bootstrap the environment and toolset.
SET _MSBUILD_TOOLSPATH=%LocalAppData%\Microsoft\dotnet

powershell ^
    -ExecutionPolicy Unrestricted ^
    -Command %REPOROOT%\.msbuild\bootstrap.ps1 ^
    -RepoRoot %REPOROOT% ^
    -ToolsPath %_MSBUILD_TOOLSPATH% ^
    -Verbose

SET PATH=%_MSBUILD_TOOLSPATH%;%PATH%

:end
