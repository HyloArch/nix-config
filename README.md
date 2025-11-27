# nix-config

Basic Nix configuration used on my devices. 

`flake.nix` will automatically build each configuration based on the contents of the `host` folder, with NixOS machines under `host/nixos` and Darwin machines under `host/darwin`. With the name of the folder as the host name, the contents are as follows:
- `default.nix`: General configurations used to initialize the system.
- `configuration.nix`: Nix configurations used in nix modules.
- `home.nix`: Home-Manager configurations used in home-manager modules.

## Host `default.nix` Attributes
- `system`: String value containing host system type.
- `modules`: List of paths to nix modules used on the entire system.
- `specialArgs`: Attribute set of additional arguments to be passed to modules.
- `users`: Attribute set of user specific config using home-manager. The key is the name of the user and the value is an attribute set containing: 
  - `homeDirectory`: String value containing the absolute path of the user's home directory.
  - `homeModules`: List of paths to home-manager modules for the current user.

Host `default.nix` can either be a function or an attribute set. As a function, it takes in an attribute set with two values:
 - `getModule`: Function that takes in a path of a module relative to the `mod` folder and returns the path relative to the current file.
 - `inputs`: Attribute set of all inputs passed down from `outputs` in `flake.nix`.
