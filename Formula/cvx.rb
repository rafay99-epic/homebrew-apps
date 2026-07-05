class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.30"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.30/cvx-darwin-arm64.tar.gz"
      sha256 "3e7762c967eb9bd7b34bbbee90191965197f01ce8930e12b452a8a6b3018a0a1"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.30/cvx-darwin-x64.tar.gz"
      sha256 "c76aad3c2e5419ab22958ef9f82686debb3fd9260ac31000c90e419da23cf86a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.30/cvx-linux-arm64.tar.gz"
      sha256 "770b8051dc692fbb923db47ec62b9d8a1db78eaf63a109280744d63a928350db"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.30/cvx-linux-x64.tar.gz"
      sha256 "eccb4b2d126d42ac8ff5bdc66cdf510fa4ceda6235f58d5f500e4130c5fd79c4"
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
