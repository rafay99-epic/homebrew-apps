cask "porter-nightly" do
  version "4"
  sha256 "2e893570de9cd5390aef6b0fc1b60d01117827746d9705ba36b08310c339164d"

  url "https://github.com/rafay99-epic/porter/releases/download/nightly/Porter-Nightly.dmg",
      verified: "github.com/rafay99-epic/porter/"
  name "Porter Nightly"
  desc "Nightly (pre-release) channel of Porter — files downloads onto your NAS"
  homepage "https://github.com/rafay99-epic/porter"

  # The `nightly` tag is a single rolling pre-release whose Porter-Nightly.dmg is
  # overwritten on every nightly build. The release CI re-pins version (= the
  # monotonic build number) + sha256 right after each build (Porter's
  # .github/scripts/bump-cask.sh), so the checksum stays honest without anyone
  # hand-editing it. Porter Nightly also self-updates from this feed. Installs
  # alongside the stable `porter` cask — separate app, icon, settings, and data.
  # Apple Silicon only.
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Porter Nightly.app"

  # Ad-hoc signed, not notarized. Strip the download quarantine so Gatekeeper
  # doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Porter Nightly.app"]
  end

  # `~/.porter-nightly` holds this channel's config + logs.
  zap trash: [
    "~/.porter-nightly",
    "~/Library/Caches/com.syntaxlabtechnology.porter.nightly",
    "~/Library/HTTPStorages/com.syntaxlabtechnology.porter.nightly",
    "~/Library/Preferences/com.syntaxlabtechnology.porter.nightly.plist",
    "~/Library/Saved Application State/com.syntaxlabtechnology.porter.nightly.savedState",
  ]
end
