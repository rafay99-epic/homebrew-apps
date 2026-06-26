cask "porter" do
  version "0.4"
  sha256 "2cd835211ce482792c6260d1fabaf03998bb074e1f107bfffa6ed67350c494d5"

  url "https://github.com/rafay99-epic/porter/releases/download/v#{version}/Porter.dmg",
      verified: "github.com/rafay99-epic/porter/"
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

  # Apple Silicon only — build.sh compiles a single arm64 slice.
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Porter.app"

  # The build is ad-hoc signed, not Apple-notarized. Strip the download
  # quarantine after install so Gatekeeper doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Porter.app"]
  end

  # `~/.porter` holds Porter's per-channel config + logs.
  zap trash: [
    "~/.porter",
    "~/Library/Caches/com.syntaxlabtechnology.porter",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.porter",
    "~/Library/Preferences/com.syntaxlabtechnology.porter.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.porter.savedState",
  ]
end
