cask "mulch" do
  version :latest
  sha256 :no_check

  url "https://github.com/rafay99-epic/mulch/releases/latest/download/Mulch.zip",
      verified: "github.com/rafay99-epic/mulch/"
  name "Mulch"
  desc "Menu bar app that clears dev junk off your Mac every week"
  homepage "https://github.com/rafay99-epic/mulch"

  # Always the latest GitHub release, so the cask never needs a bump. Mulch updates
  # itself once installed, which `auto_updates` tells Homebrew.
  auto_updates true
  depends_on macos: :tahoe

  app "Mulch.app"

  # Signed with a self-signed identity, not notarized. Strip the download
  # quarantine so Gatekeeper doesn't block first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Mulch.app"]
  end

  # Menu bar app with no Dock icon, so quit by bundle id.
  uninstall quit: "com.rafay99.mulch"

  zap trash: [
    "~/.config/mulch",
    "~/Library/Application Support/Mulch",
    "~/.mulch",
    "~/Library/Preferences/com.rafay99.mulch.plist",
  ]
end
