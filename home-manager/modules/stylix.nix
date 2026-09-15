{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeModules.stylix ];

  home.packages = with pkgs; [
  #  dejavu_fonts
  #  jetbrains-mono
  #  noto-fonts
  #  noto-fonts-lgc-plus
  #  texlivePackages.hebrew-fonts
  #  noto-fonts-emoji
  #  font-awesome
  #  powerline-fonts
  #  powerline-symbols
  #  (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/0x96f.yaml";

    targets = {
    #  hyprland.enable = false;
    };

    cursor = {
      name = "DMZ-Black";
      size = 24;
      package = pkgs.vanilla-dmz;
    };

    image = pkgs.fetchurl {
      url = "https://codeberg.org/lunik1/nixos-logo-gruvbox-wallpaper/raw/branch/master/png/gruvbox-dark-rainbow.png";
      sha256 = "036gqhbf6s5ddgvfbgn6iqbzgizssyf7820m5815b2gd748jw8zc";
    };
  };
}