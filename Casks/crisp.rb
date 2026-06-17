cask "crisp" do
  version "0.2"
  sha256 "0e49971720640949f05ae5f5337f41409ebd3b28d8633e5937f0e952672d60c6"

  url "https://github.com/rafay99-epic/Crisp/releases/download/v#{version}/Crisp.dmg",
      verified: "github.com/rafay99-epic/Crisp/"
  name "Crisp"
  desc "Auto-remove pauses and filler words from screen recordings and videos"
  homepage "https://github.com/rafay99-epic/Crisp"

  # Pinned version + checksum so Homebrew verifies every download. `livecheck`
  # lets `brew livecheck` / `brew bump-cask-pr` detect new releases; bump
  # `version` + `sha256` here each Stable cut. (Crisp also self-updates once
  # installed, so an installed copy stays current between cask bumps.)
  livecheck do
    url :url
    strategy :github_latest
  end

  # Apple Silicon only — the engine binaries (ffmpeg/whisper) ship as arm64.
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Crisp.app"

  # The build is ad-hoc signed, not Apple-notarized. Strip the download
  # quarantine after install so Gatekeeper doesn't block first launch — this is
  # what lets `brew install --cask` open cleanly without notarization.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Crisp.app"]
  end

  # `~/.crisp` holds the speech model Crisp downloads on first run (~148 MB).
  zap trash: [
    "~/.crisp",
    "~/Library/Caches/com.syntaxlabtechnology.crisp",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.crisp",
    "~/Library/Preferences/com.syntaxlabtechnology.crisp.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.crisp.savedState",
  ]
end
