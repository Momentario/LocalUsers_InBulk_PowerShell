# PowerShell User Creation Script

A PowerShell script for creating local Windows user accounts with automatically generated usernames and secure passwords.

## Features

- **Automatic Username Generation**: Creates usernames in `firstname.lastname` format
- **Custom User Descriptions**: Add personalized descriptions for each user account
- **Secure Password Generation**: Generates 13-character passwords with complexity requirements
- **Administrator Privilege Check**: Ensures script runs with proper permissions
- **Group Membership**: Adds users to both Users and Administrators groups
- **Error Handling**: Comprehensive error handling with colored output
- **Customizable**: Easy to modify user list and settings

## Prerequisites

- Windows PowerShell 5.1 or PowerShell Core 6+
- Administrator privileges
- Windows 10/11 or Windows Server

## Usage

1. **Run PowerShell as Administrator**
   - Right-click on PowerShell in Start menu
   - Select "Run as Administrator"

2. **Set execution policy (if needed)**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
   ```
   *Note: This temporarily allows script execution for the current PowerShell session only*

3. **Navigate to script directory**
   ```powershell
   cd C:\path\to\your\script
   ```

4. **Execute the script**
   ```powershell
   .\ScriptV1.ps1
   ```

## Configuration

### Adding Users

Edit the `$users` hashtable in the script:

```powershell
$users = @{
    "Firstname Lastname" = "Custom description here"
}
```

Each user entry consists of:
- **Key**: Full name of the user
- **Value**: Description that will be added to the user account

### Password Settings

The script generates 13-character passwords with:
- Lowercase letters (a-z)
- Uppercase letters (A-Z)
- Numbers (0-9)
- Special characters (!@#$%^&*()_+-=[]{}|;:,.<>?)

To modify password length, change the `$length` variable in the `Generate-Password` function.

## Security Considerations

- **Store passwords securely**: The script displays passwords in the console - ensure you save them securely
- **Administrator access**: Created users are added to the Administrators group by default
- **Password complexity**: Passwords meet Windows complexity requirements
- **Audit trail**: Consider logging user creation for security auditing

## Functions

### `Generate-Username($fullname)`
- Converts full names to `firstname.lastname` format
- Removes special characters from last names
- Converts to lowercase

### `Generate-Password`
- Creates secure 13-character passwords
- Ensures complexity requirements are met
- Uses recursive generation if complexity fails

## Error Handling

The script handles common errors:
- Insufficient privileges
- Duplicate usernames
- Invalid characters in names
- Group membership failures

## Output

- ✅ **Green**: Successful user creation
- 🔷 **Cyan**: User descriptions
- 🔐 **Yellow**: Generated passwords
- ❌ **Red**: Error messages

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Changelog

### v1.0.0
- Initial release
- Basic user creation functionality
- Administrator privilege checking
- Secure password generation

## Support

For issues or questions:
1. Check the error messages in the console
2. Ensure you're running as Administrator
3. Verify PowerShell execution policy allows script execution
4. Create an issue in this repository

## Disclaimer

This script creates local user accounts with Administrator privileges. Use responsibly and in accordance with your organization's security policies.
