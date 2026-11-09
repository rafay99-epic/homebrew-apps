cask "vitals-nightly" do
  version "63"
  sha256 "d3f98d463cc508a17e584717951b6dbce2d3d1fe2f55fd9efd5dff8cae177d5f"

  url "https://github.com/rafay99-epic/Vitals/releases/download/nightly/Vitals-Nightly.dmg"
  name "Vitals Nightly"
  desc "Nightly (pre-release) channel of the Vitals hardware monitor"
  homepage "https://github.com/rafay99-epic/Vitals"

  # The `nightly` tag is a single rolling pre-release whose Vitals-Nightly.dmg is
  # overwritten on every nightly build. The release CI re-pins version (= the
  # monotonic build number) + sha256 right after each build (Vitals's
  # .github/scripts/bump-cask.sh), so the checksum stays honest without anyone
  # hand-editing it. Vitals Nightly also self-updates from this feed. Installs
  # alongside the stable `vitals` cask — separate app, icon, settings, and data.
  depends_on macos: :sequoia

  app "Vitals Nightly.app"

  zap trash: [
    "~/Library/Caches/com.syntaxlabtechnology.vitals.nightly",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.vitals.nightly",
    "~/Library/Preferences/com.syntaxlabtechnology.vitals.nightly.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.vitals.nightly.savedState",
  ]
end
