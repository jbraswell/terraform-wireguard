.PHONY: docs
docs:
	terraform-docs markdown terraform/aws/ > terraform/aws/README.md
	terraform-docs markdown terraform/do/ > terraform/do/README.md
