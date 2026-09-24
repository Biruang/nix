{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.amdDrivers = {
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = with self.nixosModules; [];
  in {
    imports = modules;

    environment = {
      systemPackages = with pkgs; [
        mesa
        vulkan-tools
      ];
    };

    boot = {
      initrd.kernelModules = ["amdgpu"];
      kernelParams = ["radeon.si_support=0" "amdgpu.si_support=1"];
    };

    services = {
      xserver.videoDrivers = ["amdgpu"];
    };

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

    #For Rocm
    systemd.tmpfiles.rules = [
      "L+ /opt/rocm - - - - ${pkgs.rocmPackages.clr}"
    ];
  };
}
