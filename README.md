# homebrew-apps

Homebrew tap for [Syntax Lab Technology](https://rafay99.com) macOS apps.

## Vitals

A native macOS hardware monitor + app manager — [github.com/rafay99-epic/Vitals](https://github.com/rafay99-epic/Vitals).

```sh
brew install --cask rafay99-epic/apps/vitals
```

Or tap first, then install:

```sh
brew tap rafay99-epic/apps
brew install --cask vitals
```

Vitals updates itself after that. To remove it:

```sh
brew uninstall --cask vitals        # remove the app
brew uninstall --zap --cask vitals  # also remove its settings
```

### Vitals Dev (bleeding edge)

The Dev channel — every branch build before release. Installs as a **separate**
**Vitals Dev** app (own icon + settings) that sits next to your stable copy and
auto-updates from the pre-release feed.

```sh
brew install --cask rafay99-epic/apps/vitals-dev
```

### Note on the security prompt

Vitals is ad-hoc signed, not Apple-notarized (notarization needs a paid Apple
Developer account). The cask strips the download quarantine on install, so it
opens without the "Apple could not verify…" prompt. A direct `.dmg` download
from the releases page will still show that prompt — installing via Homebrew is
the smoothest path.
