{
  description = "Waizatsu Engine Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        isDarwin = pkgs.stdenv.isDarwin;
        isLinux = pkgs.stdenv.isLinux;

        # Common packages for all supported systems
        basePackages = with pkgs; [
          clang # LLVM compiler
          clang-tools # For clangd, clang-tidy, clang-format
          bear # Generate compile_commands.json
          git # Version control
          zlib # Data compression library
          figlet # ASCII art text
          openal # Software implementation of the OpenAL 3D audio API
          vulkan-tools-lunarg # LunarG Vulkan Tools and Utilities
        ];

        linuxPackages = with pkgs; [
          gcc
          llvm
          libxkbcommon # Keyboard keymap compiler and support library
          xorg.libX11
          xorg.libxcb
          xorg.libXinerama
          xcb-util-cursor
          # NOTE: glibc (stdenv.cc.cc.lib) is provided by stdenv automatically
          # and is not usually needed here.
        ];

        shellHook = ''
          #!/usr/bin/env zsh

          REPO_NAME=$(basename "$PWD")
          PROPER_REPO_NAME="''${REPO_NAME^}"
          figlet "$PROPER_REPO_NAME"
          echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
          echo
        '';
      in
        {
          devShells = if pkgs.stdenv.isLinux then {
            default = pkgs.mkShell {
              packages = basePackages ++ linuxPackages;
              inherit shellHook;
            };
          } else {
            # Will provide shells for non-linux systems in the future
          };
        });
}
