.PHONY: docs
docs:
	terraform-docs markdown terraform/alicloud/ > terraform/alicloud/README.md
	terraform-docs markdown terraform/aws/ > terraform/aws/README.md
	terraform-docs markdown terraform/azure/ > terraform/azure/README.md
	terraform-docs markdown terraform/do/ > terraform/do/README.md
	terraform-docs markdown terraform/gcp/ > terraform/gcp/README.md
	terraform-docs markdown terraform/generic/ > terraform/generic/README.md
	terraform-docs markdown terraform/ibm/ > terraform/ibm/README.md
	terraform-docs markdown terraform/linode/ > terraform/linode/README.md
	terraform-docs markdown terraform/oci/ > terraform/oci/README.md
	terraform-docs markdown terraform/upcloud/ > terraform/upcloud/README.md
	terraform-docs markdown terraform/serverspace/ > terraform/serverspace/README.md
	terraform-docs markdown terraform/vultr/ > terraform/vultr/README.md

.PHONY: fmt
fmt:
	terraform fmt --recursive terraform
