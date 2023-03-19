


Describe "Azure Storage Account Compliance" {
    

    BeforeAll -ErrorAction Stop {
        Write-Host 'Perform terraform init...'
        terraform init
        Write-Host 'Perform terraform validate...'
        terraform validate
        Write-Host 'Perform terraform plan...'
        terraform plan -out terraform.plan
        Write-Host 'Convert the plan output to Json...'
        $plan = terraform show -json terraform.plan  | ConvertFrom-Json
    }

    It "should have the correct name" {
        $expectedStorageAccountName = "sademotestpester123"   
        $storageAccountobj = $plan.resource_changes  | Where-Object { $_.address -eq 'azurerm_storage_account.storage' }
        $saName = $storageAccountobj.change.after.name
        $saName | Should -Be $expectedStorageAccountName
    }

    It "should be access only with HTTPS" {
        $expectedsaAccessHttps = "true"   
        $storageAccountobj = $plan.resource_changes  | Where-Object { $_.address -eq 'azurerm_storage_account.storage' }
        $saAccessHttps = $storageAccountobj.change.after.enable_https_traffic_only
        $saAccessHttps | Should -Be $expectedsaAccessHttps
    }

    AfterAll {
        Write-Host 'Delete the terraform.plan file'
        Remove-Item -Path .\terraform.plan
    }

}

