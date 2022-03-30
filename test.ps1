Import-Module Pester -MinimumVersion 5.2
$container = New-PesterContainer -Path $PSScriptRoot\Certificate.tests.ps1 -Data @{ Urls = Import-Csv .\urls.csv }
$cfg = [PesterConfiguration]@{
Run=@{
    Container = $container
    SkipRemainingOnFailure = $true
    Exit=$true
}
TestResult = @{
    Enabled = $true
    OutputFormat = 'JUnitXml'
}
Output = @{
    Verbosity = 'Detailed'
}
}
Remove-Item testResults.xml -ErrorAction Ignore
Invoke-Pester -Configuration $cfg