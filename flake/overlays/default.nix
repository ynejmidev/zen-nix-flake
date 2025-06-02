{ withSystem, ... }:
{
  flake.overlays = rec {
    zen-browser =
      final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        # perSystem parameters. Note that perSystem does not use `final` or `prev`.
        { config, ... }:
        {
          inherit (config.packages) zen-browser;
        }
      );
    default = zen-browser;
  };
}
