.PHONY: docs
docs:
	ls -1d terraform/*/ | xargs -I % /bin/bash -c 'terraform-docs markdown %/ > %/README.md';

.PHONY: fmt
fmt:
	terraform fmt --recursive terraform
