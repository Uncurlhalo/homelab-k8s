fmt: 
	terraform fmt --recursive

fmt-check:
	terraform fmt -check --recursive

init:
	terraform init -backend=false -input=false

test: fmt-check init
	terraform validate

plan:
	terraform init -upgrade && terraform plan

deploy:
	terraform init -upgrade && terraform apply

destroy:
	terraform init -upgrade && terraform destroy

cluster: test
	terraform apply -var-file="example.tfvars"

.PHONY: fmt fmt-check init test deploy destroy