class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.33"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.33/cvx-darwin-arm64.tar.gz"
      sha256 "41ff66de24391827d0b72de6a5f9ae9bc1d0b383436e05e0cdae14fbee5e8074"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.33/cvx-darwin-x64.tar.gz"
      sha256 "cc81294f9474b30204d609692c724193254cdb7d2546bcd4b0cec60a29e48394"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.33/cvx-linux-arm64.tar.gz"
      sha256 "1179af0a515bd489fa42f7e04ea8ad500a4c7e496f98af31288ea5ab88de9679"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.33/cvx-linux-x64.tar.gz"
      sha256 "d0145397d17bac4d405fa2480edd5d995c3249ef2b703a2e1f684e1852353ca7"
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
