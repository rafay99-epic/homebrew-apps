cask "quill-nightly" do
  version "6"
  sha256 "832abce7ce08eb5cd34c9bfaee370b4f2b89534ab8f4f4cc0384ab24fbbe66a1"

  url "https://github.com/rafay99-epic/Quill/releases/download/nightly/Quill-Nightly.dmg",
      verified: "github.com/rafay99-epic/Quill/"
  name "Quill Nightly"
  desc "Nightly (pre-release) channel of Quill — local dictation app for macOS"
  homepage "https://github.com/rafay99-epic/Quill"

  # The `nightly` tag is a single rolling pre-release whose Quill-Nightly.dmg is
  # overwritten on every nightly build. The release CI re-pins version (= the
  # monotonic build number) + sha256 right after each build
  # (.github/scripts/bump-cask.sh), so the checksum stays honest without anyone
  # hand-editing it. Quill Nightly also self-updates from this feed. Installs
  # alongside the stable `quill` cask — separate app, icon, settings, and data.
  # Apple Silicon only.
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Quill Nightly.app"

  # Ad-hoc signed, not notarized. Strip the download quarantine so Gatekeeper
  # doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Quill Nightly.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.prakashjoshipax.VoiceInk",
    "~/Library/Caches/com.syntaxlabtechnology.quill.nightly",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.quill.nightly",
    "~/Library/Preferences/com.syntaxlabtechnology.quill.nightly.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.quill.nightly.savedState",
  ]
end
