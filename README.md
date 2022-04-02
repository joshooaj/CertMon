[![Test Certificates](https://github.com/joshooaj/CertMon/actions/workflows/test.yaml/badge.svg)](https://github.com/joshooaj/CertMon/actions/workflows/test.yaml)

# Certificate Monitor

This repo is an example of how one might use PowerShell with Pester and GitHub Actions to casually monitor the status of multiple web servers and their certificates. By "casually", I mean that this is using GitHub Actions with a cronjob trigger so at best you would know a system is offline in ~5 minutes.

The original intent was to monitor the certificate status of a few sites and find out if the certificates were approaching expiration. Therefore a GitHub Action running a few times a day more than meets that expectation.
