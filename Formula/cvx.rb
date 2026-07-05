class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.49"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.49/cvx-darwin-arm64.tar.gz"
      sha256 "19ce6f9abd3626e85d830261ccf7ad5816d1e7cac7f98dcf556ead31bf668c42"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.49/cvx-darwin-x64.tar.gz"
      sha256 "44a1ae4d87653041664746113a909fb860b11f962f0ef2a2c805ba4295032a4c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.49/cvx-linux-arm64.tar.gz"
      sha256 "795f26d6c5d5fb8ff49e57fb1a6016fb88ba43474f8931481805aeb7a7824cf7"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.49/cvx-linux-x64.tar.gz"
      sha256 "4e55ed9a0ba79d7c7965d09ffd7e111dca3f65ff6193bfa2cbe1bfcda9b29d86"
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
