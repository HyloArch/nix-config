{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      pkgs.thunderbird
    ];
  };
}
