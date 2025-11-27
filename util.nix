inputs:
rec {
  getModule = mod: ./mod + mod;
  mkNixOSUser =
    host:
    user: config:
    {
      imports = (config.homeModules or [ ]) ++ [
        ({ ... }: {
          home = {
            username = user;
            homeDirectory = config.homeDirectory;
          };
        })
        ./host/nixos/${host}/home.nix
        ./mod/home-manager
      ];
    };
  mkNixOSHost =
    host:
    fileType:
    if fileType == "directory" then
      let
        module = import ./host/nixos/${host};
        config = if builtins.isFunction module then
            module { inherit inputs; inherit getModule; }
          else module;
      in inputs.nixpkgs.lib.nixosSystem {
        system = config.system;
        modules = (config.modules or [ ]) ++ [
          ({ ... }: {
            networking.hostName = host;
          })
          ./mod
          ./host/nixos/${host}/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = builtins.mapAttrs (mkNixOSUser host) config.users;
              backupFileExtension = "hm-bkup";
            };
          }
        ];
        specialArgs = { inherit inputs; } // (config.specialArgs or { });
      }
    else { };
  mkDarwinUser =
    host:
    user: config:
    {
      imports = (config.homeModules or [ ]) ++ [
        ({ lib, ... }: {
          home = {
            username = user;
            homeDirectory = lib.mkForce config.homeDirectory;
          };
        })
        ./host/darwin/${host}/home.nix
        ./mod/home-manager
      ];
    };
  mkDarwinHost =
    host:
    fileType:
    if fileType == "directory" then
    let
      module = import ./host/darwin/${host};
      config = if builtins.isFunction module then
          module { inherit inputs; inherit getModule; }
        else module;
      in inputs.darwin.lib.darwinSystem {
        system = config.system;
        modules = (config.modules or [ ]) ++ [
          ({ ... }: {
            networking.hostName = host;
          })
          ./mod
          ./host/darwin/${host}/configuration.nix
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = builtins.mapAttrs (mkDarwinUser host) config.users;
              backupFileExtension = "hm-bkup";
            };
          }
        ];
        specialArgs = { inherit inputs; } // (config.specialArgs or { });
      }
    else { };
}
