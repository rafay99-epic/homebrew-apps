cask "crisp-nightly" do
  version "81"
  sha256 "e7122e4e9e886f52c3de9ec52f20e2b3db1a674c1bba1e814a6a943e45e0c517"

  url "https://github.com/rafay99-epic/Crisp/releases/download/nightly/Crisp-Nightly.dmg",
      verified: "github.com/rafay99-epic/Crisp/"
  name "Crisp Nightly"
  desc "Nightly (pre-release) channel of Crisp — pause & filler-word remover"
  homepage "https://github.com/rafay99-epic/Crisp"

  # The `nightly` tag is a single rolling pre-release whose Crisp-Nightly.dmg is
  # overwritten on every nightly build. The release CI re-pins version (= the
  # monotonic build number) + sha256 right after each build (Crisp's
  # .github/scripts/bump-cask.sh), so the checksum stays honest without anyone
  # hand-editing it. Crisp Nightly also self-updates from this feed. Installs
  # alongside the stable `crisp` cask — separate app, icon, settings, and data.
  # Apple Silicon only.
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
