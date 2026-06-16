cask "vitals-nightly" do
  version :latest
  sha256 :no_check

  url "https://github.com/rafay99-epic/Vitals/releases/download/nightly/Vitals-Nightly.dmg"
  name "Vitals Nightly"
  desc "Nightly (pre-release) channel of the Vitals hardware monitor"
  homepage "https://github.com/rafay99-epic/Vitals"

  # Tracks the rolling `nightly` pre-release; Vitals Nightly also self-updates
  # from it. Installs alongside the stable `vitals` cask — separate app, icon,
  # settings, and data.
  depends_on macos: :sequoia

  app "Vitals Nightly.app"

  # Ad-hoc signed, not notarized. Strip the download quarantine so Gatekeeper
  # doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Vitals Nightly.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.syntaxlabtechnology.vitals.nightly.plist",
    "~/Library/Caches/com.syntaxlabtechnology.vitals.nightly",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.vitals.nightly",
    "~/Library/Saved Application State/com.syntaxlabtechnology.vitals.nightly.savedState",
  ]
end
