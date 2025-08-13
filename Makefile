create-jenkins-infra:
	@echo "Checking current subscription..."
	@CURRENT_SUB=$$(az account show --query name -o tsv); \
	if [ "$$CURRENT_SUB" != "ARO Hosted Control Planes (EA Subscription 1)" ]; then \
		echo "Error: Current subscription '$$CURRENT_SUB' is not supported"; \
		echo "Please switch to 'ARO Hosted Control Planes (EA Subscription 1)' using:"; \
		echo "  az account set --subscription 'ARO Hosted Control Planes (EA Subscription 1)'"; \
		exit 1; \
	fi
	@echo "✓ Using correct subscription: ARO Hosted Control Planes (EA Subscription 1)"
	@echo "Reading SSH public key..."
	$(eval SSH_KEY := $(shell cat ~/.ssh/id_ed25519.pub))
	@if [ -z "$(SSH_KEY)" ]; then \
		echo "Error: Could not read SSH public key from ~/.ssh/id_ed25519.pub"; \
		echo "Please ensure the file exists and is readable"; \
		echo "You can generate a new SSH key pair using:"; \
		echo "  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519"; \
		exit 1; \
	fi
	@echo "Deploying bicep template at subscription scope..."
	az deployment sub create \
		--name supatil-test-infra \
		--location westus3 \
		--template-file scripts/jenkins-server.bicep \
		--parameters sshPublicKey='$(SSH_KEY)'
