class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.59"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.59/cvx-darwin-arm64.tar.gz"
      sha256 "bae6b58d6a0ee891fdfbb768e68037ce786cbb692a3087f10d2e2ac5d1eeb8ff"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.59/cvx-darwin-x64.tar.gz"
      sha256 "dd0903f080a443489b5993bbd3a8f192e9c68d664bcbb757678d2a98ef7e2b00"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.59/cvx-linux-arm64.tar.gz"
      sha256 "46caa09bf1bb2a90cc46963c8c7da715921f1af901b7756f083a4d1bdec3f207"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.59/cvx-linux-x64.tar.gz"
      sha256 "5f10f9ef41ddd7170bb1dd977aa0ebe8664981136cf4082ce320828f4003b82b"
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
