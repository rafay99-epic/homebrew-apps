cask "porter-nightly" do
  # `:no_check` is intentional: the `nightly` tag is a single rolling pre-release
  # whose Porter-Nightly.dmg is overwritten on every nightly build, so any pinned
  # checksum would be stale within hours. The stable `porter` cask is
  # version-pinned with a real sha256 — install that if you want verification.
  version :latest
  sha256 :no_check

  url "https://github.com/rafay99-epic/porter/releases/download/nightly/Porter-Nightly.dmg",
      verified: "github.com/rafay99-epic/porter/"
  name "Porter Nightly"
  desc "Nightly (pre-release) channel of Porter — files downloads onto your NAS"
  homepage "https://github.com/rafay99-epic/porter"

  # Tracks the rolling `nightly` pre-release; Porter Nightly also self-updates
  # from it. Installs alongside the stable `porter` cask — separate app, icon,
  # settings, and data. Apple Silicon only.
  #
  # NOTE: the porter repo is PRIVATE — `brew install` needs a GitHub token with
  # repo read access (set HOMEBREW_GITHUB_API_TOKEN) to download the release asset.
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
