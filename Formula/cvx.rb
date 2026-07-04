class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.24"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.24/cvx-darwin-arm64.tar.gz"
      sha256 "fc2e17eb6c709d859ca704b61bc5ab2c37782324a3c42a64fcd31fb8d552d7bb"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.24/cvx-darwin-x64.tar.gz"
      sha256 "082596ea43ccb962dbd9f8e9b62c12252383f1f08b3db2dc1ff8c0c26efc3c05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.24/cvx-linux-arm64.tar.gz"
      sha256 "ad30606f06993e0c51aee295e85c978afd599963025def19b711a39971e30162"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.24/cvx-linux-x64.tar.gz"
      sha256 "2602249937aa5a278445a74abc7543f6dd76ae437ae339fa8b13e8bb7874f3d9"
    end
  end

  def install
    bin.install "cvx"
    man1.install "cvx.1"
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
