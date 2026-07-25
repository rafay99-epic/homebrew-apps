cask "wryte" do
  version "1.4.40"
  sha256 "2bed60d6a8c2e0cb02b7f88210a3763a10d8ecaec0e9fb4ee586e108867c0e76"

  url "https://github.com/rafay99-epic/wryte.xyz/releases/download/v#{version}/Wryte.dmg",
      verified: "github.com/rafay99-epic/wryte.xyz/"
  name "Wryte"
  desc "Git-native content workspace — markdown editor that publishes to GitHub"
  homepage "https://wryte.xyz"

  # Pinned version + checksum so Homebrew verifies every download. The release CI
  # auto-bumps both on each tag (wryte.xyz's .github/scripts/bump-cask.sh), so
  # nobody hand-edits a sha256. `livecheck` lets `brew livecheck` detect new
  # releases; Wryte also self-updates once installed (electron-updater).
  livecheck do
    url :url
    strategy :github_latest
  end

  # Apple Silicon — the macOS build ships as an arm64 dmg.
  depends_on arch: :arm64

  app "Wryte.app"

  # The build is ad-hoc signed, not Apple-notarized. Strip the download
  # quarantine after install so Gatekeeper doesn't block first launch — this is
  # what lets `brew install --cask` open cleanly without notarization.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Wryte.app"]
  end

  zap trash: [
    "~/Library/Application Support/Wryte",
    "~/Library/Caches/xyz.wryte.desktop",
    "~/Library/Caches/xyz.wryte.desktop.ShipIt",
    "~/Library/HTTPStorages/xyz.wryte.desktop",
    "~/Library/Preferences/xyz.wryte.desktop.plist",
    "~/Library/Saved Application State/xyz.wryte.desktop.savedState",
  ]
end
