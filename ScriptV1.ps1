# List of full names to process
$users = @{
    "Med Momentario" = "Description can be added right here"
    "TESTING GNITSET" = "Description is full now"
}

# Check if running as Administrator
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    exit 1
}

Write-Host "Running with Administrator privileges - proceeding with user creation..." -ForegroundColor Green
Write-Host ""

function Generate-Username($fullname) {
    $parts = $fullname -split "\s+"
    $first = $parts[0].ToLower()
    $last = $parts[-1].ToLower() -replace "[^a-z]", ""
    return "$first.$last"
}

function Generate-Password {
    $length = 13
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>?'
    $password = -join ((1..$length) | ForEach-Object { $chars[(Get-Random -Minimum 0 -Maximum $chars.Length)] })

    # Ensure complexity: lowercase, uppercase, number, special char
    if ($password -match '[a-z]' -and $password -match '[A-Z]' -and $password -match '\d' -and $password -match '[^a-zA-Z\d]') {
        return $password
    } else {
        return Generate-Password
    }
}

foreach ($fullName in $users.Keys) {
    $username = Generate-Username $fullName
    $password = Generate-Password
    $description = $users[$fullName]
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force

    try {
        # Create the local user
        New-LocalUser -Name $username `
                      -Password $securePassword `
                      -FullName $fullName `
                      -Description $description `
                      -PasswordNeverExpires

        # Add to Users and Administrators groups
        Add-LocalGroupMember -Group "Users" -Member $username
        Add-LocalGroupMember -Group "Administrators" -Member $username

        # Output result
        Write-Host "Created user: $username" -ForegroundColor Green
        Write-Host "Description: $description" -ForegroundColor Cyan
        Write-Host "Password: $password" -ForegroundColor Yellow
    }
    catch {
        $errorMessage = $_.Exception.Message
        Write-Host "Error creating user $username`: $errorMessage" -ForegroundColor Red
    }
}
