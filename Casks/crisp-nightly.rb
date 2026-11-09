cask "crisp-nightly" do
  version "95"
  sha256 "6eb38c77f7381e8e9f8552cd20f344c13b7e5fd77e954c14397f2412c81936a4"

  url "https://github.com/rafay99-epic/Crisp/releases/download/nightly/Crisp-Nightly.dmg"
  name "Crisp Nightly"
  desc "Nightly (pre-release) channel of the Crisp pause and filler-word remover"
  homepage "https://github.com/rafay99-epic/Crisp"

  depends_on arch: :arm64
  # The `nightly` tag is a single rolling pre-release whose Crisp-Nightly.dmg is
  # overwritten on every nightly build. The release CI re-pins version (= the
  # monotonic build number) + sha256 right after each build (Crisp's
  # .github/scripts/bump-cask.sh), so the checksum stays honest without anyone
  # hand-editing it. Crisp Nightly also self-updates from this feed. Installs
  # alongside the stable `crisp` cask — separate app, icon, settings, and data.
  # Apple Silicon only.
  depends_on macos: :sonoma

  app "Crisp Nightly.app"

  # `~/.crisp-nightly` holds the speech model this channel downloads on first run.
  zap trash: [
    "~/.crisp-nightly",
    "~/Library/Caches/com.syntaxlabtechnology.crisp.nightly",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.crisp.nightly",
    "~/Library/Preferences/com.syntaxlabtechnology.crisp.nightly.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.crisp.nightly.savedState",
  ]
end
