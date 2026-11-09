cask "crisp" do
  version "0.20"
  sha256 "7fe74ead74144e4f69dd11b98ee2bc5fb7ec67c52cb02b4cbb5f1136053b9ed0"

  url "https://github.com/rafay99-epic/Crisp/releases/download/v#{version}/Crisp.dmg"
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

  depends_on arch: :arm64
  # Apple Silicon only — the engine binaries (ffmpeg/whisper) ship as arm64.
  depends_on macos: :sonoma

  app "Crisp.app"

  # `~/.crisp` holds the speech model Crisp downloads on first run (~148 MB).
  zap trash: [
    "~/.crisp",
    "~/Library/Caches/com.syntaxlabtechnology.crisp",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.crisp",
    "~/Library/Preferences/com.syntaxlabtechnology.crisp.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.crisp.savedState",
  ]
end
