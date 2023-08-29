# Generate the makefile to install Nix
install-nix:
    curl -L https://nixos.org/nix/install | sh

# Install rclone
install-rclone:
    curl https://rclone.org/install.sh | sudo bash

AGE_VERSION := 1.1.1
INSTALL_DIR := /usr/local/bin
AGE_URL_BASE := https://github.com/FiloSottile/age/releases/download/v$(AGE_VERSION)
install-age:
	@echo "Installing age..."
	@case `uname` in \
		"Darwin") \
			curl -fsSL $(AGE_URL_BASE)/age-macos-arm64.tar.gz -o age && tar xvfz age.tar.gz; \
			;; \
		"Linux") \
			curl -fsSL $(AGE_URL_BASE)/age-v$(AGE_VERSION)-linux-amd64.tar.gz -o age.tar.gz && tar xvfz age.tar.gz; \
			;; \
		*) \
			echo "Unsupported operating system"; \
			exit 1; \
			;; \
	esac
	@sudo mv age/age $(INSTALL_DIR)/age
	@rm -r age/ age.tar.gz
	@echo "age installed successfully."

# Run the script
run-script:
	python script.py
