cask "quill" do
  version "0.1506"
  sha256 "e59811c159d0573028e9000591f97c7368b7d7498a7332b9ba84e9c94bb9a99d"

  url "https://github.com/rafay99-epic/Quill/releases/download/v#{version}/Quill.dmg"
  name "Quill"
  desc "Local whisper.cpp dictation app, a personal fork of VoiceInk"
  homepage "https://github.com/rafay99-epic/Quill"

  # Pinned version + checksum so Homebrew verifies every download. `livecheck`
  # lets `brew livecheck` / `brew bump-cask-pr` detect new releases; the release
  # CI rewrites `version` + `sha256` here on each Stable cut
  # (.github/scripts/bump-cask.sh). Quill also self-updates once installed.
  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  # Apple Silicon only.
  depends_on macos: :sonoma

  app "Quill.app"

  # Ad-hoc signed, not Apple-notarized. Strip the download quarantine after
  # install so Gatekeeper doesn't block first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Quill.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.prakashjoshipax.VoiceInk",
    "~/Library/Caches/com.syntaxlabtechnology.quill",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.quill",
    "~/Library/Preferences/com.syntaxlabtechnology.quill.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.quill.savedState",
  ]
end
