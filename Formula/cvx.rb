class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.6"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.6/cvx-darwin-arm64.tar.gz"
      sha256 "a8f7072ed91aafefb26ce2284d8707e1c2544ae9e0c0fe51d7ebe6b02592de03"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.6/cvx-darwin-x64.tar.gz"
      sha256 "ca39705dbeed578420074a3c3e960bd4eb384a16cb76e963a6e08a24bd4bd76e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.6/cvx-linux-arm64.tar.gz"
      sha256 "1d86320f6d67e761a6b80e5db439be41ea4d5001c4fc8c5e6d2f4caa433d781d"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.6/cvx-linux-x64.tar.gz"
      sha256 "65087dc4f49537ec7f6316f17f55bc52acf53ec6e7802d6d1133276faeec20cb"
    end
  end

  def install
    bin.install "cvx"
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
