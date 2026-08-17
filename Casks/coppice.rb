cask "coppice" do
  version "0.8"
  sha256 "2b98d559a6cd8afa1bbb4ee0df2af3ba53b4030b475afc93ba167edd12c1af06"

  url "https://github.com/rafay99-epic/Coppice/releases/download/v#{version}/Coppice.dmg",
      verified: "github.com/rafay99-epic/Coppice/"
  name "Coppice"
  desc "Safely reclaims disk from git worktrees left behind by coding agents"
  homepage "https://github.com/rafay99-epic/Coppice"

  # Pinned version + checksum so Homebrew verifies every download. The release CI
  # auto-bumps both on each Stable cut (Coppice's .github/scripts/bump-cask.sh), so
  # nobody hand-edits a sha256. `livecheck` lets `brew livecheck` detect new
  # releases; Coppice also self-updates once installed.
  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Coppice.app"

  # The build is ad-hoc signed, not Apple-notarized. Strip the download
  # quarantine after install so Gatekeeper doesn't block first launch — this is
  # what lets `brew install --cask` open cleanly without notarization.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Coppice.app"]
  end

  # Coppice is a menu bar app with no Dock icon, so quit it through the bundle id
  # rather than by name before the bundle is replaced or removed.
  uninstall quit: "com.syntaxlabtechnology.coppice"

  zap trash: [
    "~/Library/Application Support/Coppice",
    "~/Library/Caches/com.syntaxlabtechnology.coppice",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.coppice",
    "~/Library/Preferences/com.syntaxlabtechnology.coppice.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.coppice.savedState",
  ]
end
