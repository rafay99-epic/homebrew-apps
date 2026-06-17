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

## Crisp

A native macOS app that auto-removes pauses and filler words from screen
recordings and talking-head videos — [github.com/rafay99-epic/Crisp](https://github.com/rafay99-epic/Crisp).

```sh
brew install --cask rafay99-epic/apps/crisp
```

Or tap first, then install:

```sh
brew tap rafay99-epic/apps
brew install --cask crisp
```

Crisp updates itself after that. On first run it downloads its speech model
(~148 MB) once. Apple Silicon only. To remove it:

```sh
brew uninstall --cask crisp        # remove the app
brew uninstall --zap --cask crisp  # also remove its settings + downloaded model
```

### Crisp Nightly (pre-release)

The Nightly channel — every integration build before a stable release. Installs
as a **separate** **Crisp Nightly** app (own icon + settings + data) that sits
next to your stable copy and auto-updates from the pre-release feed.

```sh
brew install --cask rafay99-epic/apps/crisp-nightly
```

## Note on the security prompt

These apps are ad-hoc signed, not Apple-notarized (notarization needs a paid
Apple Developer account). The casks strip the download quarantine on install, so
they open without the "Apple could not verify…" prompt. A direct `.dmg` download
from the releases page will still show that prompt — installing via Homebrew is
the smoothest path.
