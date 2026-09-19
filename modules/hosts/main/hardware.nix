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

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/5d753022-74c2-4747-ba3b-b1b959029549";
      fsType = "btrfs";
      options = ["subvol=rootfs"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/5d753022-74c2-4747-ba3b-b1b959029549";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/5d753022-74c2-4747-ba3b-b1b959029549";
      fsType = "btrfs";
      options = ["subvol=home"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/2D08-EEDC";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    fileSystems."/var/lib/docker/btrfs" = {
      device = "/home/rootfs/var/lib/docker/btrfs";
      fsType = "none";
      options = ["bind"];
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
