Import-Module Pester -MinimumVersion 5.2
$container = New-PesterContainer -Path $PSScriptRoot\Certificate.tests.ps1
$cfg = [PesterConfiguration]@{
    Run        = @{
        Container              = $container
        SkipRemainingOnFailure = $true
        Exit                   = $true
    }
    TestResult = @{
        Enabled      = $true
        OutputFormat = 'JUnitXml'
    }
    Output     = @{
        Verbosity = 'Detailed'
    }
}
Invoke-Pester -Configuration $cfg