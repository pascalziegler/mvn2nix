let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    overlays = [
      (_: super: rec {
        gh-md-toc-source = super.fetchurl {
          url =
            "https://raw.githubusercontent.com/ekalinin/github-markdown-toc/0.8.0/gh-md-toc";
          sha256 = "sha256-xgPQJECj0a+ea5pZoCVk0ThbF0XXyUcs3sGcVNtXJvw=";
        };
        gh-md-toc = super.writeScriptBin "gh-md-toc" ''
          ${super.runtimeShell} ${gh-md-toc-source} "$@"
        '';
      })
    ];
  };
in pkgs.mkShell {
  name = "mvn2nix-shell";
  buildInputs = with pkgs; [ jdk11_headless maven gh-md-toc ];

  # we need to set M2_HOME to our Maven which uses JDK11
  M2_HOME = pkgs.maven;
  shellHook = "";
}
