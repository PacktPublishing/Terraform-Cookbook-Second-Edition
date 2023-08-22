clear-tg: ## Delete all .terragrunt-cache directory
	find terragrunt/ -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;

clear-tf: ## Delete all .terraform directory
	find . -type d -name ".terraform" -prune -exec rm -rf {} \;


clear-tflock: ## Delete all .terraform.lock file
	find . -type f -name ".terraform.lock.hcl" -prune -exec rm -rf {} \;

clear-tfstate: ## Delete all .terraform.lock file
	find . -type f -name "terraform.tfstate" -prune -exec rm -rf {} \;