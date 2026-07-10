cask "vitals" do
  version "0.69"
  sha256 "7e0c79beac37d2c0ea7119e837a66ec2417dc27adf97c4f9107feab18054797f"

  url "https://github.com/rafay99-epic/Vitals/releases/download/v#{version}/Vitals.dmg",
      verified: "github.com/rafay99-epic/Vitals/"
  name "Vitals"
  desc "Native macOS hardware monitor and app manager"
  homepage "https://github.com/rafay99-epic/Vitals"

  # Pinned version + checksum so Homebrew verifies every download. The release CI
  # auto-bumps both on each Stable cut (Vitals's .github/scripts/bump-cask.sh), so
  # nobody hand-edits a sha256. `livecheck` lets `brew livecheck` detect new
  # releases; Vitals also self-updates once installed.
  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Vitals.app"

  # The build is ad-hoc signed, not Apple-notarized. Strip the download
  # quarantine after install so Gatekeeper doesn't block first launch — this is
  # what lets `brew install --cask` open cleanly without notarization.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Vitals.app"]
  end

  zap trash: [
    "~/Library/Caches/com.syntaxlabtechnology.vitals",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.vitals",
    "~/Library/Preferences/com.syntaxlabtechnology.vitals.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.vitals.savedState",
  ]
end
