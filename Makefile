/etc/nixos/configuration.nix:
	ln -sft /etc/nixos $(CURDIR)/configuration.nix

clean:
	rm /etc/nixos/configuration.nix
