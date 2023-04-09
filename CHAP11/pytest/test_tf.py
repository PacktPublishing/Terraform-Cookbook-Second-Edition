import pytest
import subprocess
import json

@pytest.fixture(scope="session")
def terraform_plan_output():
    # Run the Terraform plan command to generate the state file
    subprocess.run(["terraform", "plan", "-out", "plan.tfout"])

    # Run the Terraform show command on the state file to get the plan output as JSON
    show_output = subprocess.check_output(["terraform", "show", "-json", "plan.tfout"])

    # Parse the Terraform show output as JSON and return as a dictionary
    return json.loads(show_output)


def test_storage_account_https_only_enabled(terraform_plan_output):
    # Get the value of the 'enable_https_traffic_only' property
    enable_https_traffic_only = terraform_plan_output['resource_changes'][1]['change']['after']['enable_https_traffic_only']

    # Assert that the 'enable_https_traffic_only' property is set to True
    assert enable_https_traffic_only == True
