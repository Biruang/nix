{
  self,
  moduleWithSystem,
  lib,
  ...
}: {
  flake.homeModules.vscode = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = with self.homeModules; [];
  in {
    imports = modules;

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "vscode"
        "vscode-extension-ms-vscode-remote-remote-ssh"
      ];

    programs.vscode = {
      enable = true;
      package = self'.packages.myVscode;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          kamadorueda.alejandra
          ms-vscode-remote.remote-ssh
        ];
        userSettings = {
          #For Nix IDE
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.formatterPath" = "nixfmt";
          "nix.serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = ["nixfmt"];
              };
              "options" = {
                "nixos" = {
                  "expr" = "(builtins.getFlake \"/home/nix\").nixosConfigurations.main.options";
                };
                "home-manager" = {
                  "expr" = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.main.options.home-manager.users.type.getSubOptions []";
                };
              };
            };
          };
          #For Alejandra
          "[nix]" = {
            "editor.defaultFormatter" = "kamadorueda.alejandra";
            "editor.formatOnPaste" = true;
            "editor.formatOnSave" = true;
            "editor.formatOnType" = false;
          };
          "alejandra.program" = "alejandra";
        };
      };
    };
  });
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myVscode = pkgs.vscode;
  };
}
