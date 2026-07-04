class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.18"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.18/cvx-darwin-arm64.tar.gz"
      sha256 "a283e1496770d8ba7c07cf5f41387995b88e7a164532e14510077274718b25bb"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.18/cvx-darwin-x64.tar.gz"
      sha256 "77aef03cc693f5b7eef1b85949f4c1ac93a0f63a2e9c99a1fb47e10faf05d872"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.18/cvx-linux-arm64.tar.gz"
      sha256 "334bcc7c5cc85bd6f1dc2b6086b5d91e1c0054b73ee630caf62c1ca53104a86c"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.18/cvx-linux-x64.tar.gz"
      sha256 "c88487f006d5581f0c39b4770acb8b9e731c5fcf0a539618e38fb25b4db03e47"
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
