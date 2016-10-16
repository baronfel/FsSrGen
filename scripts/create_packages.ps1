$initDir = $pwd

#make path absolute
$repoDir = Split-Path -parent (Split-Path -parent $PSCommandPath)

Push-Location

# restore

cd "$repoDir\src"

dotnet restore
if (-not $?) {
	exit 1
}

# create src/fssrgen package

cd "$repoDir\src\fssrgen"

dotnet --verbose pack -c Release --output "$repoDir\bin\packages"
if (-not $?) {
	exit 1
}

# create src/FSharp.SRGen.Build.Tasks package

cd "$repoDir\src\FSharp.SRGen.Build.Tasks"

dotnet --verbose pack -c Release --output "$repoDir\bin\packages"
if (-not $?) {
	exit 1
}

# crete src/dotnet-fssrgen package

cd "$repoDir\src\dotnet-fssrgen"

dotnet --verbose pack -c Release --output "$repoDir\bin\packages"
if (-not $?) {
	exit 1
}

# Done

Pop-Location

$pwd = $initDir 

exit 0
