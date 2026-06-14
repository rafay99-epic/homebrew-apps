cask "vitals-dev" do
  version :latest
  sha256 :no_check

  url "https://github.com/rafay99-epic/Vitals/releases/download/dev/Vitals-Dev.dmg"
  name "Vitals Dev"
  desc "Dev (pre-release) channel of the Vitals hardware monitor"
  homepage "https://github.com/rafay99-epic/Vitals"

  # Tracks the rolling `dev` pre-release; Vitals Dev also self-updates from it.
  # It installs alongside the stable `vitals` cask — separate app, icon, settings.
  depends_on macos: :sequoia

  app "Vitals Dev.app"

  # Ad-hoc signed, not notarized. Strip the download quarantine so Gatekeeper
  # doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Vitals Dev.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.syntaxlabtechnology.vitals.dev.plist",
    "~/Library/Caches/com.syntaxlabtechnology.vitals.dev",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.vitals.dev",
    "~/Library/Saved Application State/com.syntaxlabtechnology.vitals.dev.savedState",
  ]
end
