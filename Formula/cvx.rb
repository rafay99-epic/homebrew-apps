class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.38"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.38/cvx-darwin-arm64.tar.gz"
      sha256 "831cb3974e724971f0e2106322751c121d071cfecbedf53d14f0edd235023fd3"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.38/cvx-darwin-x64.tar.gz"
      sha256 "a3e5fe7896fcab9dfe4fc0a1f3143fa1514e90babd92013e9c6eb8b37a447dde"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.38/cvx-linux-arm64.tar.gz"
      sha256 "80cddf8bb208bb92144baacc1fca855a2b5aaf12855637ac13c5c1fc8c104b7f"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.38/cvx-linux-x64.tar.gz"
      sha256 "9211d2e011856859d1c10e290b7cf7e3a29a09be7402af0e93837ec17465428a"
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
