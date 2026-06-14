cask "vitals" do
  version :latest
  sha256 :no_check

  url "https://github.com/rafay99-epic/Vitals/releases/latest/download/Vitals.dmg",
      verified: "github.com/rafay99-epic/Vitals/"
  name "Vitals"
  desc "Native macOS hardware monitor and app manager"
  homepage "https://github.com/rafay99-epic/Vitals"

  # Vitals updates itself from GitHub Releases, so Homebrew shouldn't manage upgrades.
  auto_updates true
  depends_on macos: ">= :sequoia"

  app "Vitals.app"

  # The build is ad-hoc signed, not Apple-notarized. Strip the download
  # quarantine after install so Gatekeeper doesn't block first launch — this is
  # what lets `brew install --cask` open cleanly without notarization.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Vitals.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.syntaxlabtechnology.vitals.plist",
    "~/Library/Caches/com.syntaxlabtechnology.vitals",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.vitals",
    "~/Library/Saved Application State/com.syntaxlabtechnology.vitals.savedState",
  ]
end
