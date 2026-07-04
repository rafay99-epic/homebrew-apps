class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.16"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.16/cvx-darwin-arm64.tar.gz"
      sha256 "276d5f82c5d176e0991c2f20a092efd5c3cb6a43dbf8858ab27c1d26203514e7"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.16/cvx-darwin-x64.tar.gz"
      sha256 "a9c5401540611e802856b55cf8445517b69cf242247243340c7c91d570edb993"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.16/cvx-linux-arm64.tar.gz"
      sha256 "ddb4c5d1ca7a1a359abe9257352e5d2e1ec22866c81add65ffb59bc71dbec6b6"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.16/cvx-linux-x64.tar.gz"
      sha256 "fbba09cf22c190d912411cfb9170a45e9c0ba2a6c49807ea0e07f7b106bd0404"
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
