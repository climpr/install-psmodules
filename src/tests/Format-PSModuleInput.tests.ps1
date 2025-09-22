BeforeAll {
    Import-Module $PSScriptRoot/../InstallPSModules.psm1 -Force
}

Describe "Format-PSModuleInput" {
    It "Should handle <scenario> correctly" -TestCases @(
        @{
            scenario = "Empty string input"
            modules  = ""
            expected = ""
        }
        @{
            scenario = "Single module with no version"
            modules  = "Az.Accounts"
            expected = "Az.Accounts::"
        }
        @{
            scenario = "Single module with version"
            modules  = "Az.Accounts:2.17.0"
            expected = "Az.Accounts:2.17.0"
        }
        @{
            scenario = "Single module with explicit latest version"
            modules  = "Az.Accounts:latest"
            expected = "Az.Accounts::"
        }
        @{
            scenario = "Multiple modules with different formats"
            modules  = @"
Az.Accounts:2.17.0
Az.Billing:2.0.3
Pester:latest
Az.Storage
"@
            expected = "Az.Accounts:2.17.0,Az.Billing:2.0.3,Pester::,Az.Storage::"
        }
    ) {
        param($modules, $expected)

        $result = Format-PSModuleInput -Modules $modules

        $result | Should -BeExactly $expected
    }
}