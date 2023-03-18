


Describe "Azure Storage Account Name Compliance" {
    

    BeforeAll -ErrorAction Stop {

        Write-Host 'Initializing...'
        terraform init
        Write-Host 'Validating...'
        terraform validate
        Write-Host 'Planning...'
        (terraform plan -out terraform.plan) | Write-Host
        #terraform show -json terraform.plan > tfplan.json

        # Parse plan file and pull out provided variables
        $plan = terraform show -json terraform.plan  | ConvertFrom-Json
    }

    It "should have the correct name" {

        $expectedStorageAccountName = "sademotestpester123"   
        $storageAccountobj = $plan.resource_changes  | Where-Object { $_.address -eq 'azurerm_storage_account.storage' }
        $saName = $storageAccountobj.change.after.name
        $saName | Should -Be $expectedStorageAccountName
    }

    AfterAll {
        # Remove-Item -Path .\tfplan.json
        # Remove-Item -Path .\tfplan
    }

}

