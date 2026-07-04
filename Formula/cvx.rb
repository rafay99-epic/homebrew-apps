class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.27"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.27/cvx-darwin-arm64.tar.gz"
      sha256 "bbc187c52ce0fdba5ea18d77bb820300e5c75ed2848a235bb59f055dc925a1e7"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.27/cvx-darwin-x64.tar.gz"
      sha256 "dd90a44fbcb8755ffe299c619bfe1cefa6f2d07e1392f5c5480c76d2245e0df4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.27/cvx-linux-arm64.tar.gz"
      sha256 "1ff3b26f4e1545d4f268178d1ddeb3c49768302bba36e457f3b1a054cdb1686b"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.27/cvx-linux-x64.tar.gz"
      sha256 "2adb9fadcfe48e56b19d21882bf967274c46b564fdd898405b3747da49ceec97"
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
