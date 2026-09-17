sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake '/tmp/nix#<host>' --disk main /dev/<disk>
