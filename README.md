# zen-nix-flake
A home-manager module for the Zen Browser, using home manager's mkFirefoxModule.


## usage

- add this to your flake inputs since no browser extensions are distributed through nixpkgs (optional):

``` nix
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
```
- add an overlay to nixpkgs like this (`mkFirefoxModule` looks for the given package name `zen-browser` inside `pkgs`):

``` nix
nixpkgs.overlays =
  [
    inputs.zen-browser.overlays.default
  ];
```
- import home module

``` nix
  imports = [ inputs.zen-browser.homeModules.default ];
```

- configure exactly the same as the firefox (and friends) modules in home-manager
eg:

```nix
programs.zen-browser = {
    enable = true;
    profiles = {
        john = {
            id = 0;
            settings = {
                "zen.welcome-screen.seen" = true;
                "zen.widget.linux.transparency" = true;
                "browser.tabs.allow_transparent_browser" = true;
            };
            search.default = "ddg";
            extensions = {
                packages = with pkgs.firefox-addons; [
                   ublock-origin
                   vimium-c
                   darkreader
                ];
            };
        };
        jane = let color = "#2E154D66"; in {
            id = 1;
            userContent = ''
                @import "${inputs.zen-nebula}/Nebula/Nebula-content.css";
            '';
            userChrome = ''
                @import "${inputs.zen-nebula}/Nebula/Nebula.css";
                :root {
                    --nebula-ui-tint: light-dark(rgba(255,255,255,0.2),${color}); /* Edit the color values to change the tint of sidebar and etc. */
                }
            '';

        };
    };
};
```

## todo
``trace: using non-memoized system wasm32-wasi
trace: using non-memoized system i686-linux``
on a x86_64-linux, it builds successfully..

