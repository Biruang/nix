{inputs, ...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  #for LSP to correct align input path with flake
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
