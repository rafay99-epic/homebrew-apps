cask "crisp-nightly" do
  # `:no_check` is intentional here: the `nightly` tag is a single rolling
  # pre-release whose Crisp-Nightly.dmg is overwritten on every nightly build, so
  # any pinned checksum would be stale within hours. The stable `crisp` cask is
  # version-pinned with a real sha256 — install that if you want verification.
  version :latest
  sha256 :no_check

  url "https://github.com/rafay99-epic/Crisp/releases/download/nightly/Crisp-Nightly.dmg",
      verified: "github.com/rafay99-epic/Crisp/"
  name "Crisp Nightly"
  desc "Nightly (pre-release) channel of Crisp — pause & filler-word remover"
  homepage "https://github.com/rafay99-epic/Crisp"

  # Tracks the rolling `nightly` pre-release; Crisp Nightly also self-updates
  # from it. Installs alongside the stable `crisp` cask — separate app, icon,
  # settings, and data. Apple Silicon only.
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Crisp Nightly.app"

  # Ad-hoc signed, not notarized. Strip the download quarantine so Gatekeeper
  # doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Crisp Nightly.app"]
  end

  # `~/.crisp-nightly` holds the speech model this channel downloads on first run.
  zap trash: [
    "~/.crisp-nightly",
    "~/Library/Caches/com.syntaxlabtechnology.crisp.nightly",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.crisp.nightly",
    "~/Library/Preferences/com.syntaxlabtechnology.crisp.nightly.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.crisp.nightly.savedState",
  ]
end
