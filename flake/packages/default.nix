{ inputs, ... }:
{
  perSystem =
    {
      system,
      ...
    }:
    {
      packages = rec {
        zen-browser = inputs.zen-browser.packages.${system}.default;
        default = zen-browser;
      };
    };
}
