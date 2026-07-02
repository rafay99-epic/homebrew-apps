cask "vitals" do
  version "0.65"
  sha256 "e5b24b471822b1a3b38cb710c5fb42e137d3ad8a255360ae8ad571338ef975d1"

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
