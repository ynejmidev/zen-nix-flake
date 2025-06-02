{ inputs, ... }:
let
  modulePath = [
    "programs"
    "zen-browser"
  ];

  mkFirefoxModule = import (inputs.home-manager + /modules/programs/firefox/mkFirefoxModule.nix);
in
{
  flake.homeModules.default = mkFirefoxModule {
    inherit modulePath;
    name = "Zen";
    wrappedPackageName = "zen-browser";
    unwrappedPackageName = "zen-browser-unwrapped";
    visible = true;

    platforms.linux = {
      configPath = ".zen";
    };
    platforms.darwin = {
      configPath = "Library/Application Support/Zen"; # TODO: make sure this is the correct path on darwin
    };
  };
}
