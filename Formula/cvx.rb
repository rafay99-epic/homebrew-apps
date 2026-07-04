class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.12"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.12/cvx-darwin-arm64.tar.gz"
      sha256 "3222ac017d74012ac855c3738ff199972bd3e2431d0bb7dd1bd68cbe565ac207"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.12/cvx-darwin-x64.tar.gz"
      sha256 "09a9f1d9d02536fde541009ad8d543ff2394f96dca870d279055ad21f7384933"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.12/cvx-linux-arm64.tar.gz"
      sha256 "4fd9136c8f143e9e03ef13bb916636b6a3bbea585ca24953113f3eaf23c6cf28"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.12/cvx-linux-x64.tar.gz"
      sha256 "d754b3d3017d2374b6f0ba5dba78ca4fcace9dcd68b7ee399b82b3d1febe1471"
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
