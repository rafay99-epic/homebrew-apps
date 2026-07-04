class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.3"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.3/cvx-darwin-arm64.tar.gz"
      sha256 "21bb36de3ca0623088cb421e6de33b2439317eac616eac4f8ac9d4c24f3db8cb"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.3/cvx-darwin-x64.tar.gz"
      sha256 "ab05a579cace5ec28bd988ae8311bd6c1989841c353e294835249774f85f0be0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.3/cvx-linux-arm64.tar.gz"
      sha256 "636a6cb237f1fed0ad62856e5722f259547fc79f75fda1d3242a2ef7d41c6297"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.3/cvx-linux-x64.tar.gz"
      sha256 "9fe83e637f3869b9cb86245eac48428bb5f8dad3a7fca88477d9da5ed901e051"
    end
  end

  def install
    bin.install "cvx"
  end

  def caveats
    <<~CAVEATS
      One-time setup to enable automatic per-project account switching:

        cvx hook --install     # adds a cd-hook to ~/.zshrc
        exec zsh               # reload your shell

      Then:  cvx login <name>  ·  cvx link <account>  ·  cd into a project.
    CAVEATS
  end

  test do
    assert_match "switch Convex accounts", shell_output("#{bin}/cvx help")
  end
end
