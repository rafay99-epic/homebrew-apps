cask "porter-nightly" do
  version "6"
  sha256 "f6e5a3c0b502c380cb5588874aa2b31f698441614ce318bd96acdfca3e5470b3"

  url "https://github.com/rafay99-epic/porter/releases/download/nightly/Porter-Nightly.dmg"
  name "Porter Nightly"
  desc "Nightly (pre-release) channel of Porter, which files downloads onto a NAS"
  homepage "https://github.com/rafay99-epic/porter"

  depends_on arch: :arm64
  # The `nightly` tag is a single rolling pre-release whose Porter-Nightly.dmg is
  # overwritten on every nightly build. The release CI re-pins version (= the
  # monotonic build number) + sha256 right after each build (Porter's
  # .github/scripts/bump-cask.sh), so the checksum stays honest without anyone
  # hand-editing it. Porter Nightly also self-updates from this feed. Installs
  # alongside the stable `porter` cask — separate app, icon, settings, and data.
  # Apple Silicon only.
  depends_on macos: :sonoma

  app "Porter Nightly.app"

  # `~/.porter-nightly` holds this channel's config + logs.
  zap trash: [
    "~/.porter-nightly",
    "~/Library/Caches/com.syntaxlabtechnology.porter.nightly",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.porter.nightly",
    "~/Library/Preferences/com.syntaxlabtechnology.porter.nightly.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.porter.nightly.savedState",
  ]
end
