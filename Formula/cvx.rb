class Cvx < Formula
  desc "Per-project Convex account switching without deploy keys or tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.68"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.68/cvx-darwin-arm64.tar.gz"
      sha256 "75a65caecad53429a9586768e198ffa74b1985ad315e2ab429bd7855f6260788"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.68/cvx-darwin-x64.tar.gz"
      sha256 "617785f1c58ded79a113ed24bea1ddbae44953de3a27a502d9beeafc2ec3d4c6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.68/cvx-linux-arm64.tar.gz"
      sha256 "a04c1e1f5866057e0479525747e03e4227dd16ea4987d1e61abd8a5195bde253"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.68/cvx-linux-x64.tar.gz"
      sha256 "1994cb3d0ae8aefda6d563d6b1916ff068ce4a63c1b23da73400e1917474499c"
    end
  end

  def install
    bin.install "cvx"
    man1.install "cvx.1"
    # Tab completion out of the box: runs `cvx completions <shell>` at
    # install time and places each script where the shell expects it.
    generate_completions_from_executable(bin/"cvx", "completions")
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
