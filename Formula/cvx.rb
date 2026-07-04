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
      sha256 "ec404178266fbf175cdb9e57856a5d85b43584f3c0aca024bb0de7303fcac10e"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.12/cvx-darwin-x64.tar.gz"
      sha256 "146e460d03cfbc08739410dc2222997baa9d7f64bcca911670306b8283fe0251"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.12/cvx-linux-arm64.tar.gz"
      sha256 "3b14ddfe4bfc173a18f8c69ae478969c8d6fc5cb123cf02e65fb5d5fff9c59d9"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.12/cvx-linux-x64.tar.gz"
      sha256 "025c7db8aeb8e6df66a219257485a167f9181e926a841fb4f4e99799e5285f60"
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
