{
  self,
  moduleWithSystem,
  ...
}: {
  flake.homeModules.vscodium = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = with self.homeModules; [];
  in {
    imports = modules;
    programs.vscodium = {
      enable = true;
      package = pkgs.vscodium;
      argvSettings = {
        enable-proposed-api = [
          "jeanp413.open-remote-ssh"
        ];
      };
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          kamadorueda.alejandra
          #not in the store - sadje
          #jeanp413.open-remote-ssh
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
}
