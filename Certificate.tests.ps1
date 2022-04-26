BeforeDiscovery {
    $script:Urls = Import-Csv $PSScriptRoot\urls.csv | Foreach-Object {
        @{ Url = [uri]$_.Url }
    }
}

Describe -Name "<url>" -ForEach $Urls {
    BeforeAll {
        if ($null -eq $Url) {
            throw "Data driven test received no data. The value of `$Url is `$null"
        }
        try {
            $script:certInfo = $null
            $tcpClient        = [net.sockets.tcpclient]::new($Url.Host, $Url.Port)
            $stream           = $tcpClient.GetStream()
            $sslStream = [net.security.sslstream]::new($stream, $false, { $true })
            $sslStream.AuthenticateAsClient($Url.Host)
            $script:certInfo  = [security.cryptography.x509certificates.x509certificate2]::new($sslStream.RemoteCertificate)
        } catch {
            Write-Host "Could not connect to $Url" -ForegroundColor Red
        }
    }

    It 'is up' {
        $certInfo | Should -Not -BeNullOrEmpty
    }

    It 'is not expired' {
        $certInfo.NotAfter | Should -BeGreaterThan (Get-Date)
    }

    It 'does not expire in 30 days' {
        $certInfo.NotAfter | Should -BeGreaterThan (Get-Date).AddDays(30)
    }

    It 'is trusted certificate' {
        $certInfo.Verify() | Should -BeTrue
    }

    AfterAll {
        if ($script:sslStream) {
            $script:sslStream.Dispose()
        }
    }
}
