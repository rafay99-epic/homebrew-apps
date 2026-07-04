class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.20"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.20/cvx-darwin-arm64.tar.gz"
      sha256 "5e21d751d8ce23821d3153847c26122ae36bcd9bfb27f001485ac6d0812d9d5f"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.20/cvx-darwin-x64.tar.gz"
      sha256 "21e2c6cb2b444764ede6251137e561406139fe13e14b5a13b9eece1810679032"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.20/cvx-linux-arm64.tar.gz"
      sha256 "5f65ce7ce56bc73b82406422efcd36b0f98cdafb8f16a24697006dd5f6b5ce0e"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.20/cvx-linux-x64.tar.gz"
      sha256 "fde7442d9b207592b25060905889984e7e0c38726fd851acc4dd720098f6e6d8"
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
