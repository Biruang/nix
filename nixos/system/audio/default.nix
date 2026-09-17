{
  security.rtkit.enable = true;
  nixpkgs.config.pulseaudio = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
