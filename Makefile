RELEASE_VERSION=0.0.2
RELEASE_COMMENT="release version $(RELEASE_VERSION)"

format:
	find modules -mindepth 1 -maxdepth 1 -type d -exec sh -c 'cd "{}" && terraform fmt .' \;
	terraform fmt .

doc:
	find modules -mindepth 1 -maxdepth 1 -type d -exec sh -c 'cd "{}" && terraform-docs markdown table --output-file README.md --output-mode inject .' \;
	terraform-docs markdown table --output-file README.md --output-mode inject .

clean:
	rm -rf .terraform
	rm -rf terraform.tfstate*
	rm -rf .terraform.lock.hcl

release:
	git add .
	git commit -m $(RELEASE_COMMENT)
	git push
	git tag -a $(RELEASE_VERSION) -m $(RELEASE_COMMENT)
	git push --tags
