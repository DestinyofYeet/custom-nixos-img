{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, ... }@inputs: 
  let
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        qemu
        nixos-generators
      ];

      shellHook = ''
        nixos-generate --format iso --configuration ./img.nix -o result
        if [ $? -ne 0 ]; then
          echo "Error in nixos-generate, not starting qemu!"
        else
          qemu-system-x86_64 -m 6G --drive media=cdrom,file=result/iso/nixos-24.11pre-git-x86_64-linux.iso,format=raw,readonly=on -cpu host -smp 6 -enable-kvm -vga virtio -display gtk,gl=on
        fi
        exit
      '';
    };
  };
}
