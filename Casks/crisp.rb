cask "crisp" do
  version "0.18"
  sha256 "acc9792df03232c1e74dc640542b52f6eb3876819556df85b97f01a0a0110cd7"

  url "https://github.com/rafay99-epic/Crisp/releases/download/v#{version}/Crisp.dmg",
      verified: "github.com/rafay99-epic/Crisp/"
  name "Crisp"
  desc "Auto-remove pauses and filler words from screen recordings and videos"
  homepage "https://github.com/rafay99-epic/Crisp"

  # Pinned version + checksum so Homebrew verifies every download. The release CI
  # auto-bumps both on each Stable cut (Crisp's .github/scripts/bump-cask.sh), so
  # nobody hand-edits a sha256. `livecheck` lets `brew livecheck` detect new
  # releases; Crisp also self-updates once installed.
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
