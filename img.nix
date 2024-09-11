{ pkgs, modulesPath, lib, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/microsoft/surface/surface-pro-intel"
    # "${builtins.fetchGit { url = "https://github.com/hpfr/system"; rev = "2e5b3b967b0436203d7add6adbd6b6f55e87cf3c"; }}/hosts/linux-surface.nix"
  ];

  # use the latest Linux kernel
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" "zfs" ];

  environment.etc.rofl.text = "lol";
}
