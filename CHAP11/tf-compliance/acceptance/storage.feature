Feature: Test compliant of Azure Storage Account

  Scenario: Ensure our Azure Storage have Tag DEMO with value demo
    Given I have azurerm_storage_account defined
    Then it must contain tags
    Then it must contain DEMO
    And its value must be "book"


  Scenario: Ensure our Storage is accessible on HTTPS
    Given I have azurerm_storage_account defined
    Then it must contain enable_https_traffic_only
    And its value must be true