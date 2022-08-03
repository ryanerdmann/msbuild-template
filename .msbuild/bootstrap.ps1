<#
.SYNOPSIS
    Bootstraps the MSBuild development environment.
.DESCRIPTION
    Bootstraps the MSBuild development environment.  A portable copy of MSBuild
    is acquired via the .NET SDK, which is installed if it does not exist.
.PARAMETER RepoRoot
    The path to the root of the repository, containing the `global.json` file.
.PARAMETER ToolsPath
    The install directory for .NET Core tools.
.PARAMETER Verbose
    Displays diagnostics information.
#>
[CmdletBinding()]
param(
    [string] $RepoRoot,
    [string] $ToolsPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$Start = [DateTime]::UtcNow
Write-Host "[MSBuild] Initializing environment..."

#
# Verify and normalize inputs.
#

$RepoRoot = $RepoRoot.TrimEnd('\')

if (!(Test-Path -Path $RepoRoot -PathType Container))
{
    throw "Invalid repository root: '$RepoRoot'"
}

$TempPath = Join-Path -Path $RepoRoot -ChildPath ".msbuild\.temp"
New-Item -Path $TempPath -ItemType Directory -Force > $null


#
# Install the .NET SDK using the specific version from global.json.
#

$DotnetInstallScript = Join-Path -Path $TempPath -ChildPath 'dotnet-install.ps1'
$DotnetInstallLog = Join-Path -Path $TempPath -ChildPath 'dotnet-install.log'

if (!(Test-Path -Path $DotnetInstallScript -PathType Leaf))
{
    Invoke-WebRequest 'https://dot.net/v1/dotnet-install.ps1' -OutFile $DotnetInstallScript
}

Write-Host "[MSBuild] Installing the .NET SDK"
& $DotnetInstallScript -JsonFile "$RepoRoot\global.json" -InstallDir $ToolsPath *> $DotnetInstallLog


#
# Configure the environment.
#

DOSKEY build=dotnet msbuild $*
DOSKEY msbuild=dotnet msbuild $*

$Duration = [DateTime]::UtcNow - $Start
Write-Host "[MSBuild] Environment ready in $Duration"

Write-Host
Write-Host "  Usage: msbuild <args>"
