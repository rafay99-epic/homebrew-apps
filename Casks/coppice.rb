cask "coppice" do
  version "0.14"
  sha256 "58948af168fc340cc4a8c712b3ebe497ca049d3756268330ea75a113a1f32da8"

  url "https://github.com/rafay99-epic/Coppice/releases/download/v#{version}/Coppice.dmg"
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
