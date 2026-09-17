{inputs, ...}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    #for correct align input path with flake
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    optimise.automatic = true;
  };
}
