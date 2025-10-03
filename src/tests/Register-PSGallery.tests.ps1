
Describe "Register-PSGallery" {
    $currentPSRepository = $null

    BeforeAll {
        Import-Module $PSScriptRoot/../InstallPSModules.psm1 -Force
        $script:currentPSRepository = Get-PSRepository -Name PSGallery -ErrorAction Ignore
    }

    BeforeEach {
        if (Get-PSRepository -Name PSGallery -ErrorAction Ignore) {
            Unregister-PSRepository -Name PSGallery
        }
    }

    AfterEach {
        if ($currentPSRepository) {
            Unregister-PSRepository -Name PSGallery
            Register-PSRepository -Default -InstallationPolicy $currentPSRepository.InstallationPolicy
        }
        else {
            Unregister-PSRepository -Name PSGallery
        }
    }

    It "Should register PSGallery as trusted when Get-PSRepository is trusted" {
        Register-PSRepository -Default -InstallationPolicy Trusted
        Register-PSGallery
        $psRepository = Get-PSRepository -Name PSGallery
        $psRepository | Should -Not -BeNullOrEmpty
        $psRepository.Trusted | Should -BeTrue
    }

    It "Should register PSGallery as trusted when Get-PSRepository is not trusted" {
        Register-PSRepository -Default -InstallationPolicy Untrusted
        Register-PSGallery
        $psRepository = Get-PSRepository -Name PSGallery
        $psRepository | Should -Not -BeNullOrEmpty
        $psRepository.Trusted | Should -BeTrue
    }

    It "Should register PSGallery as trusted when Get-PSRepository returns null" {
        Register-PSGallery
        $psRepository = Get-PSRepository -Name PSGallery
        $psRepository | Should -Not -BeNullOrEmpty
        $psRepository.Trusted | Should -BeTrue
    }
}