cask "porter" do
  version "0.6"
  sha256 "985cd30e418e17d79ce3236d3ca0193fd10d757e4fbe10bb19d760cf62475577"

  url "https://github.com/rafay99-epic/porter/releases/download/v#{version}/Porter.dmg"
  name "Porter"
  desc "Watches a folder and files finished downloads onto your NAS by type"
  homepage "https://github.com/rafay99-epic/porter"

  # Pinned version + checksum so Homebrew verifies every download. `livecheck`
  # lets `brew livecheck` / `brew bump-cask-pr` detect new releases; bump
  # `version` + `sha256` here each Stable cut. (Porter also self-updates once
  # installed, so an installed copy stays current between cask bumps.)
  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  # Apple Silicon only — build.sh compiles a single arm64 slice.
  depends_on macos: :sonoma

  app "Porter.app"

  # `~/.porter` holds Porter's per-channel config + logs.
  zap trash: [
    "~/.porter",
    "~/Library/Caches/com.syntaxlabtechnology.porter",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.porter",
    "~/Library/Preferences/com.syntaxlabtechnology.porter.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.porter.savedState",
  ]
end
