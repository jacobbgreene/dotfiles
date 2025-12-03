self: super:

  let
    quickshellSrc = super.fetchgit {
      url = "https://github.com/quickshell-mirror/quickshell";
      rev = "d24e8e9736287d01ee73ef9d573d2bc316a62d5c";
      sha256 = "sha256-ynV90KoBrPe38YFlKAHtPFk4Ee3IANUsIFGxRaq7H/s=";
    };

    ignisSrc = super.fetchgit {
      url = "https://github.com/ignis-sh/ignis";
      rev = "ba8b0e11c2462afc9fdc30ce6a72b4e94e8ee7c4";
      sha256 = "sha256-7ipFVC9pvI564c22b1dIEzSQ8dZXK3cxh/tF/4tX38c=";
    };

    ignisGvcSrc = super.fetchgit {
      url = "https://github.com/ignis-sh/ignis-gvc";
      rev = "f2c9f10d8b49cc38106a2f07a51ea959c6aa4e63";
      sha256 = "sha256-ft5KvY2OYrWF+jEsfBL/Zx8Iuo2C10C6COk8wHwZw34=";
    };

    nwgDockHyprlandSrc = super.fetchgit {
      url = "https://github.com/nwg-piotr/nwg-dock-hyprland";
      rev = "f7ddf61da4722513b43820fb3b2667eb92aa0b43";
      sha256 = "sha256-a+LNABfe5rHStZrf+qlayNuCwTQf+7qY4xjx2K7Ky7E=";
    };

    quickshellPkg = super.callPackage (quickshellSrc + "/default.nix") {
      gitRev = "d24e8e9736287d01ee73ef9d573d2bc316a62d5c";
    };

    ignisVersion = "0.0.0+git.${builtins.substring 0 7 ignisSrc.rev}";
    ignisGvcPkg = super.callPackage (ignisGvcSrc + "/nix/default.nix") { };

    ignisPkg = super.callPackage (ignisSrc + "/nix/default.nix") {
      "ignis-gvc" = ignisGvcPkg;
      version = ignisVersion;
    };

  in {
    quickshell = quickshellPkg;
    "ignis-gvc" = ignisGvcPkg;
    ignis = ignisPkg;

    "nwg-dock-hyprland" = super.buildGoModule {
      pname = "nwg-dock-hyprland";
      version = "unstable-2025-07-29";
      src = nwgDockHyprlandSrc;
      vendorHash = "sha256-uHxH3g0pcfA5emF4LpvjYsSocjoFtk2p57JRSsY/PKY=";
      subPackages = [ "." ];
      nativeBuildInputs = [ super.pkg-config super.gobject-introspection ];
      buildInputs = [
        super.glib
        super.gtk3
        super.atk
        super.gdk-pixbuf
        super.pango
        super.cairo
        super.gtk4
        super.gtk-layer-shell
      ];
      };
  }
