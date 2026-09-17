{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.mainHardware = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/61b73dce-72f2-42de-8f3b-1e21986e1325";
      fsType = "btrfs";
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/61b73dce-72f2-42de-8f3b-1e21986e1325";
      fsType = "btrfs";
      options = ["subvol=home"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/61b73dce-72f2-42de-8f3b-1e21986e1325";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/E15F-1842";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/af3477ce-93b9-4b7f-9ad2-55c007836128";}
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
