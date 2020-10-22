<#
    .SYNOPSIS
    Gets the current 'StrictMode' setting. See Set-StrictMode for how to set this.
	
	.NOTES
    When -ShowAllScopes has been passed, the properties of the objects might not be ordered
    properly. If you're using PSv3 or higher, you can make the hash table where the properties
    are defined [ordered], or you can use the [PSCustomObject] accelerator.
	
	.PARAMETER CSVPath
    Specifies the path to the CSV to use
	
	.EXAMPLE
    # First, open a fresh PowerShell window and import the function.
    PS> (Get-StrictMode) -eq $null
    True
    PS> Set-StrictMode -Version 2
    PS> (Get-StrictMode) -eq $null
    False
    PS> Get-StrictMode
    Major  Minor  Build  Revision
    -----  -----  -----  --------
    2      0      -1     -1      
    This example shows how the function behaves if Set-StrictMode has never been used, and then
    what happens after it is used.
	
	.LINK
		http://unifystep.net
        
#>

function Get-Field {
    # FULL HELP AVAILABLE HERE: http://gallery.technet.microsoft.com/scriptcenter/Get-Field-Get-Public-and-7140945e
    [CmdletBinding()]
    param (
        # Specifies the object whose fields are retrieved
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $InputObject,
        # Specifies the names of one or more field names. The * wildcard is allowed.
        # Get-Field gets only the fields that satisfy the requirements of at least one of the Name strings.
        [Parameter(Position = 0)]
        [string[]] $Name = "*",
        # Gets only the value of the field(s)
        [switch] $ValueOnly
    )
 
    process {
        $Type = $InputObject.GetType()
        [string[]] $BindingFlags = "Public", "NonPublic", "Instance"

        $Type.GetFields($BindingFlags) | Where-Object {
            foreach ($CurrentName in $Name) {
                if ($_.Name -like $CurrentName) { 
                    return $true
                }
            }
        } | ForEach-Object {
            $CurrentField = $_

            $CurrentFieldValue = $Type.InvokeMember($CurrentField.Name, $BindingFlags + "GetField", $null, $InputObject, $null)
            if ($ValueOnly) {
                $CurrentFieldValue
            }
            else {
                $ReturnProperties = @{}
                foreach ($PropName in Write-Output Name, IsPublic, IsPrivate) {
                    $ReturnProperties.$PropName = $CurrentField.$PropName
                }

                $ReturnProperties.Value = $CurrentFieldValue
                New-Object PSObject -Property $ReturnProperties
            }
        } 
    }
}

function Get-StrictMode {   
    # First scope appears to be from Get-Field scope, so ignore it and just get the parent
    # Second scope should be from this function, so ignore it and get its parent.
    $CurrentScope = $ExecutionContext | Get-Field _context -ValueOnly | 
        Get-Field _engineSessionState -ValueOnly | 
        Get-Field currentScope -ValueOnly | 
        Get-Field *Parent* -ValueOnly |
        Get-Field *Parent* -ValueOnly
    $Scope = 0 # Keeps track of the scope that's being examined

    # Walk through scopes (this will continue to loop until there is no parent
    while ($CurrentScope) {
        # Field names use wild cards since ISE uses '<[FieldNameHere]>k__BackingField'
        # and console just uses [FieldName]
        $StrictModeVersion = $CurrentScope | Get-Field *StrictModeVersion* -ValueOnly
        return $StrictModeVersion.Major
    }
}
