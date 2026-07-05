class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.35"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.35/cvx-darwin-arm64.tar.gz"
      sha256 "c5e438bd0b5e9a9fbf4f8c85cb38778660572b95fea6b4ef1d2c67fe4ef14c8f"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.35/cvx-darwin-x64.tar.gz"
      sha256 "ea098b12462f298a41a340802a9caedb5980d94dfb76d8254937a85d70b9fb37"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.35/cvx-linux-arm64.tar.gz"
      sha256 "e508841354b1b220da3b45c069e3c2049707829a1c1287dc59c419a9a3208f00"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.35/cvx-linux-x64.tar.gz"
      sha256 "0bd7d4a6704648fd7c37985b1f710ee736d5409906adae51f911a08bf573a45d"
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
