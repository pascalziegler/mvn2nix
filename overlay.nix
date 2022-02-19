final: prev: {
  jdk = prev.jdk11_headless;

  mvn2nix = final.callPackage ./derivation.nix { };

  mvn2nix-bootstrap = final.callPackage ./derivation.nix { bootstrap = true; };

  buildMavenRepository =
    (final.callPackage ./maven.nix { }).buildMavenRepository;

  buildMavenRepositoryFromLockFile =
    (final.callPackage ./maven.nix { }).buildMavenRepositoryFromLockFile;
}
