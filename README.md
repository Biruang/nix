sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko/master#disko-install' -- --write-efi-boot-entries --flake '/home/nixos/<host>#main' --disk main /dev/<disk>
