{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mesa
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    vulkan-tools
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
        rocmPackages.clr.icd
      ];
    };
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };

  boot = {
    initrd.kernelModules = ["amdgpu"];
    kernelParams = ["radeon.si_support=0" "amdgpu.si_support=1"];
  };

  services.xserver.videoDrivers = ["amdgpu"];

  #For Rocm
  systemd.tmpfiles.rules = [
    "L+ /opt/rocm - - - - ${pkgs.rocmPackages.clr}"
  ];
}
