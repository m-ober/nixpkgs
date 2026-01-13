{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchYarnDeps,
  yarnConfigHook,
  yarnBuildHook,
  nodejs,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "strichliste-frontend";
  version = "1.7.1";

  src = fetchFromGitHub {
    owner = "strichliste";
    repo = "strichliste-web-frontend";
    rev = "v${finalAttrs.version}";
    hash = "sha256-r9R//4XE85dkChLSu+Sn8Yo72dNZY8Z3yDHOiYIYjwg=";
  };

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = finalAttrs.src + "/yarn.lock";
    hash = "sha256-NVQpXMiKVgFnAxLvl+BhFqXZU51D2CWfrVs5e/m4bMs=";
  };

  env.NODE_OPTIONS = "--openssl-legacy-provider";

  nativeBuildInputs = [
    yarnConfigHook
    yarnBuildHook
    # Needed for executing package.json scripts
    nodejs
  ];

  installPhase = ''
    mkdir $out
    cp -R public/* $out/
  '';

  meta = {
    description = "strichliste is a tool to replace a tally sheet.";
    homepage = "https://www.strichliste.org/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.all;
  };
})
