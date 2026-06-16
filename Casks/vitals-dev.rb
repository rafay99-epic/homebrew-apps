cask "vitals-dev" do
  version :latest
  sha256 :no_check

  url "https://github.com/rafay99-epic/Vitals/releases/download/dev/Vitals-Dev.dmg"
  name "Vitals Dev"
  desc "Dev (pre-release) channel of the Vitals hardware monitor — discontinued, use vitals-nightly"
  homepage "https://github.com/rafay99-epic/Vitals"

  # SUNSET: the published Dev channel has been replaced by Nightly. This cask
  # tracks a frozen final `dev` pre-release and no longer receives updates —
  # switch to `vitals-nightly`. `deprecate!` prints a warning on install/upgrade;
  # `caveats` spells out the migration.
  deprecate! date: "2026-06-17", because: "the Dev channel is now Nightly — install rafay99-epic/apps/vitals-nightly instead"

  # Tracks a frozen final `dev` pre-release; no longer self-updates.
  depends_on macos: :sequoia

  app "Vitals Dev.app"

  caveats <<~EOS
    Vitals Dev has been replaced by Vitals Nightly and no longer receives updates.
    Switch to the Nightly channel:

      brew uninstall --cask vitals-dev
      brew install --cask rafay99-epic/apps/vitals-nightly

    (Nightly installs as a separate app with its own icon, settings, and data.)
  EOS

  # Ad-hoc signed, not notarized. Strip the download quarantine so Gatekeeper
  # doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Vitals Dev.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.syntaxlabtechnology.vitals.dev.plist",
    "~/Library/Caches/com.syntaxlabtechnology.vitals.dev",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.vitals.dev",
    "~/Library/Saved Application State/com.syntaxlabtechnology.vitals.dev.savedState",
  ]
end
