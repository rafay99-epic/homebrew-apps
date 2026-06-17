cask "crisp" do
  version :latest
  sha256 :no_check

  url "https://github.com/rafay99-epic/Crisp/releases/latest/download/Crisp.dmg"
  name "Crisp"
  desc "Auto-remove pauses and filler words from screen recordings and videos"
  homepage "https://github.com/rafay99-epic/Crisp"

  # `version :latest` always tracks the newest release; Crisp also self-updates.
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
