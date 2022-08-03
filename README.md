# MSBuild Project Template

This repository is a technical demonstration of a modern, enterprise-class project
using the MSBuild engine.

Notable features include:
- Consistent environment bootstrapping via `init.cmd`, governed by `global.json`
- A portable MSBuild executable, via the [dotnet msbuild](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-msbuild) command
- Multiple project types expressed via [MSBuild SDKs](https://docs.microsoft.com/en-us/visualstudio/msbuild/how-to-use-project-sdk)
- Central Package Mangaement via [Directory.Packages.Props](https://devblogs.microsoft.com/nuget/introducing-central-package-management/)
- Project tree support via `dirs.proj` [Traversal Projects](https://github.com/microsoft/MSBuildSdks/tree/main/src/Traversal)
- VS Solution support via [slngen](https://microsoft.github.io/slngen/)

### Getting Started

```
> git clone https://github.com/ryanerdmann/msbuild-template.git
> init.cmd
> msbuild /restore
```

