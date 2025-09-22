BeforeAll {
    Import-Module $PSScriptRoot/../InstallPSModules.psm1 -Force
}

Describe "Register-PSGallery" {
    It "Should register PSGallery as trusted when Get-PSRepository returns null" {
        InModuleScope InstallPSModules {
            Mock -CommandName Get-PSRepository -MockWith { $null }
            Mock -CommandName Unregister-PSRepository
            Mock -CommandName Register-PSRepository

            Register-PSGallery

            Should -Invoke Get-PSRepository -Times 1 -Exactly
            Should -Invoke Unregister-PSRepository -Times 1 -Exactly
            Should -Invoke Register-PSRepository -Times 1 -Exactly
        }
    }
    
    # It "Should register PSGallery as trusted when not trusted from before" {
    #     InModuleScope InstallPSModules {
    #         Mock -CommandName Get-PSRepository -MockWith { @{} }
    #         Mock -CommandName Unregister-PSRepository
            
    #         Register-PSGallery
            
    #         Should -Invoke Get-PSRepository -Times 1 -Exactly -ModuleName InstallPSModules
    #         Should -Invoke Unregister-PSRepository -Times 1 -Exactly -ModuleName InstallPSModules
    #     }
    # }
}