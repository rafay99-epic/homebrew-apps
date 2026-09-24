cask "coppice-nightly" do
  version "12"
  sha256 "21bd45fe2cff0d68d2c3589b1bb8e058e75d1b9cc6335e752d6f1823005a7beb"

  url "https://github.com/rafay99-epic/Coppice/releases/download/nightly/Coppice-Nightly.dmg"
  name "Coppice Nightly"
  desc "Nightly (pre-release) channel of the Coppice worktree cleaner"
  homepage "https://github.com/rafay99-epic/Coppice"

  # The `nightly` tag is a single rolling pre-release whose Coppice-Nightly.dmg is
  # overwritten on every nightly build. The release CI re-pins version (= the
  # monotonic build number) + sha256 right after each build (Coppice's
  # .github/scripts/bump-cask.sh), so the checksum stays honest without anyone
  # hand-editing it. Version is the build number rather than the commit count
  # because several nightly builds can share a commit — the commit count would
  # sit still and Homebrew would never offer the upgrade. Coppice Nightly also
  # self-updates from this feed. Installs alongside the stable `coppice` cask —
  # separate app, icon, settings, and data.
  depends_on macos: :sequoia

  app "Coppice Nightly.app"

  # Ad-hoc signed, not notarized. Strip the download quarantine so Gatekeeper
  # doesn't block first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Coppice Nightly.app"]
  end

  # Menu bar app with no Dock icon, so quit by bundle id rather than by name.
  uninstall quit: "com.syntaxlabtechnology.coppice.nightly"

  zap trash: [
    "~/Library/Application Support/Coppice Nightly",
    "~/Library/Caches/com.syntaxlabtechnology.coppice.nightly",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.coppice.nightly",
    "~/Library/Preferences/com.syntaxlabtechnology.coppice.nightly.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.coppice.nightly.savedState",
  ]
end
