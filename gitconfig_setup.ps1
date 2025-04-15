# Prompt user for BHP username, git username and email used for git
$targetUser =  Read-Host "Enter your BHP username"
$username = Read-Host "Enter your Git username"
$email = Read-Host "Enter your Git email"


$gitconfigPath = "C:\Users\$targetUser\.gitconfig"

# Ensure file exists
if (!(Test-Path $gitconfigPath)) {
    Write-Host "Creating new .gitconfig for $targetUser..."
    "" | Out-File $gitconfigPath -Encoding utf8
}

# Load gitconfig settings
$config = Get-Content $gitconfigPath

# Validate if user section exists
if ($config -match '^\[user\]') {
    # Replace name/email lines
    $config = $config -replace 'name\s*=.*', "    name = $username"
    $config = $config -replace 'email\s*=.*', "    email = $email"
} else {
    # Append new user section
    $config += "`n[user]`n    name = $username`n    email = $email"
}

# Save updated config
$config | Set-Content $gitconfigPath -Encoding utf8

Write-Host "`n.gitconfig updated successfully for user: $targetUser"
