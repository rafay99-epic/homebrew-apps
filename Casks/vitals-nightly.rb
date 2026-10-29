cask "vitals-nightly" do
  version "58"
  sha256 "5e661d84f8ba34abe52e481b71d25e9b0138c696af63202abe9721b937eb4252"

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

  # Ad-hoc signed, not notarized. Strip the download quarantine so Gatekeeper
  # doesn't block first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Vitals Nightly.app"]
  end

  zap trash: [
    "~/Library/Caches/com.syntaxlabtechnology.vitals.nightly",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.vitals.nightly",
    "~/Library/Preferences/com.syntaxlabtechnology.vitals.nightly.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.vitals.nightly.savedState",
  ]
end
