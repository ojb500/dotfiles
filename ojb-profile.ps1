# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


function Push-NewGitRemoteBranch()
{
	$Branch = git rev-parse --abbrev-ref HEAD
	if (-not $?) {
		throw "Couldn't get current branch"
	}
	$Branch = $Branch.Trim()
	$BranchSpec = $Branch + ":users/oli/$Branch"
	echo "pushing $BranchSpec"
	git push -u origin $BranchSpec
    start $(git remote get-url origin)
}

# Import-Module oh-my-posh
Import-Module posh-git
$GitPromptSettings.EnablePromptStatus = $false

$env:POSH_GIT_ENABLED = $True
oh-my-posh init pwsh --config "$PSScriptRoot\tiwahu-ojb.omp.json" | Invoke-Expression

$PROFILE = $PSCommandPath
$DOTFILE_PATH = $PSScriptRoot

$editors = @("c:\Program Files\Sublime Text 3\subl.exe")

$EDITOR = ""
foreach ($ed in $editors)
{
	if (test-path $ed)
	{
		$EDITOR = $ed
		break
	}
}

function open-editor {
	param($path)
	. $EDITOR $path
}
function open-dotfiles { 
	start $DOTFILE_PATH
}

set-alias nano open-editor
set-alias subl open-editor


function edit-profile
{
	open-editor $PROFILE
}

