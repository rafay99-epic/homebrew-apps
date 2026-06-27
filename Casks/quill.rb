cask "quill" do
  version "0.1501"
  sha256 "39c2541318c373372f5085f92aba28eaf193b536d7d3a3b87673ec84c3c7eed0"

  url "https://github.com/rafay99-epic/Quill/releases/download/v#{version}/Quill.dmg",
      verified: "github.com/rafay99-epic/Quill/"
  name "Quill"
  desc "Local whisper.cpp dictation app for macOS (personal fork of VoiceInk)"
  homepage "https://github.com/rafay99-epic/Quill"

  # Pinned version + checksum so Homebrew verifies every download. `livecheck`
  # lets `brew livecheck` / `brew bump-cask-pr` detect new releases; the release
  # CI rewrites `version` + `sha256` here on each Stable cut
  # (.github/scripts/bump-cask.sh). Quill also self-updates once installed.
  livecheck do
    url :url
    strategy :github_latest
  end

  # Apple Silicon only.
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Quill.app"

  # Ad-hoc signed, not Apple-notarized. Strip the download quarantine after
  # install so Gatekeeper doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Quill.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.prakashjoshipax.VoiceInk",
    "~/Library/Caches/com.syntaxlabtechnology.quill",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.quill",
    "~/Library/Preferences/com.syntaxlabtechnology.quill.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.quill.savedState",
  ]
end
