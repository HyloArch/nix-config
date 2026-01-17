{...}:
{
  config = {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
      ports = [
        8493
      ];
    };
    users.users.hyloarch.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBs6NoDs2gPGSEMvbntkGlWoefdNUmMiooXTXiv/at2/ hyloarch@neovexata"
    ];
  };
}
