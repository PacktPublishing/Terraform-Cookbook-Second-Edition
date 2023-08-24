terraform {
  required_version = "~> 1.1"
  required_providers {
    # Because we're currently using a built-in provider as
    # a substitute for dedicated Terraform language syntax
    # for now, test suite modules must always declare a
    # dependency on this provider. This provider is only
    # available when running tests, so you shouldn't use it
    # in non-test modules.
    test = {
      source = "terraform.io/builtin/test"
    }

  }
}


module "storage" {
  source = "../.."
}

resource "test_assertions" "https" {
  # "component" serves as a unique identifier for this
  # particular set of assertions in the test results.
  component = "https"

  # equal and check blocks serve as the test assertions.
  # the labels on these blocks are unique identifiers for
  # the assertions, to allow more easily tracking changes
  # in success between runs.

  equal "scheme" {
    description = "https must be enabled"
    got         = module.storage.https_enabled
    want        = true
  }

}

resource "test_assertions" "storageName" {
  # "component" serves as a unique identifier for this
  # particular set of assertions in the test results.
  component = "name"

  # equal and check blocks serve as the test assertions.
  # the labels on these blocks are unique identifiers for
  # the assertions, to allow more easily tracking changes
  # in success between runs.

  check "storage_name" {
    description = "storage name must finish by 123"
    condition   = can(regex("^123", module.storage.storage_name))
  }
}