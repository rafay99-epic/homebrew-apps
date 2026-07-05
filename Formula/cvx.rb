class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.42"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.42/cvx-darwin-arm64.tar.gz"
      sha256 "2f72cec683a1e415c60d333ca50dc7d4381b9d00107518cda9b32f798ddc85d5"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.42/cvx-darwin-x64.tar.gz"
      sha256 "f6f7226a0b6952ed64507be85a55c33b0cb380ef6f2344a076ee27beb538ab40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.42/cvx-linux-arm64.tar.gz"
      sha256 "e1a5e142756d6b8fc3e7b9cba0d19c3f8f0dd3512d2e19498da3d2d85825c88d"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.42/cvx-linux-x64.tar.gz"
      sha256 "a954302c32541bae69baf7dd652e1cdde6541ce1943caa95b61dff87750ca150"
    end
  end

  def install
    bin.install "cvx"
    man1.install "cvx.1"
    # Tab completion out of the box: runs `cvx completions <shell>` at
    # install time and places each script where the shell expects it.
    generate_completions_from_executable(bin/"cvx", "completions", shells: [:zsh, :bash, :fish])
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
