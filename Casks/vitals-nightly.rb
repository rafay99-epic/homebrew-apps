cask "vitals-nightly" do
  version "31"
  sha256 "22252d4296e71c90f30d3a396ca3d40ccaf3219cf803ce90f9b14ebcd48ce09a"

  url "https://github.com/rafay99-epic/Vitals/releases/download/nightly/Vitals-Nightly.dmg",
      verified: "github.com/rafay99-epic/Vitals/"
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
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Vitals Nightly.app"]
  end

  zap trash: [
    "~/Library/Caches/com.syntaxlabtechnology.vitals.nightly",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.vitals.nightly",
    "~/Library/Preferences/com.syntaxlabtechnology.vitals.nightly.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.vitals.nightly.savedState",
  ]
end
