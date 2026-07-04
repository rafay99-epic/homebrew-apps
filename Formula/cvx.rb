class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.14"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.14/cvx-darwin-arm64.tar.gz"
      sha256 "266f87f65d5791fa01bdbcf37b17982fb1dc37c0cd2c7d77c8df7828be24352e"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.14/cvx-darwin-x64.tar.gz"
      sha256 "f7daac66ba682b13f0f0e9ad3dc6af153d118eb32c5f3772973f630b938cf484"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.14/cvx-linux-arm64.tar.gz"
      sha256 "e2fc0612d769a2aa9c0264d97c3473be410f486ae0d49328b1ab439977cc3293"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.14/cvx-linux-x64.tar.gz"
      sha256 "c1abffc01275ebfa52efd35defe277c48936a31b30d88328766a49e7db0081c3"
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
