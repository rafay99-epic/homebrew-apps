cask "coppice-nightly" do
  version "14"
  sha256 "3f440112ada61f09616c1ba540f5df61e94d832de09974c8f8040c6ed2db53f3"

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
