.PHONY: docs
docs:
	terraform-docs markdown terraform/aws/ > terraform/aws/README.md
	terraform-docs markdown terraform/do/ > terraform/do/README.md
	terraform-docs markdown terraform/linode/ > terraform/linode/README.md
	terraform-docs markdown terraform/vultr/ > terraform/vultr/README.md

.PHONY: fmt
fmt:
	terraform fmt --recursive terraform
