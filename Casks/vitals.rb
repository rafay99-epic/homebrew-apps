cask "vitals" do
  version "0.80"
  sha256 "6b82083e364e7cb03b8b08a4f68e555f92b4d632597ef05dc4bb23c2cbf6bb80"

  url "https://github.com/rafay99-epic/Vitals/releases/download/v#{version}/Vitals.dmg"
  name "Vitals"
  desc "Native hardware monitor and app manager"
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

  zap trash: [
    "~/Library/Caches/com.syntaxlabtechnology.vitals",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.vitals",
    "~/Library/Preferences/com.syntaxlabtechnology.vitals.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.vitals.savedState",
  ]
end
