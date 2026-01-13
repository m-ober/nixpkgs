{
  lib,
  fetchFromGitHub,
  php81,
}:

php81.buildComposerProject2 (finalAttrs: {
  pname = "strichliste-backend";
  version = "1.8.2";

  src = fetchFromGitHub {
    owner = "strichliste";
    repo = "strichliste-backend";
    tag = "v${finalAttrs.version}";
    hash = "sha256-BlV7tynQKM2rEmnGjO4NuiutBVMDuT4di2oJjdz2suU=";
  };

  vendorHash = "sha256-Z+86UfMJczfK8z7sQBoDxeJnlbzq/28s66ifuXlJCms=";
  composerNoDev = true;
  composerStrictValidation = false;

  postInstall = ''
    mkdir $out/bin
    ln -s $out/share/php/strichliste-backend/bin/console $out/bin/strichliste-console
  '';

  meta = {
    description = "strichliste is a tool to replace a tally sheet.";
    homepage = "https://www.strichliste.org/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.all;
  };
})
