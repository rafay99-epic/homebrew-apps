class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.55"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.55/cvx-darwin-arm64.tar.gz"
      sha256 "c4cf12b2b8fb6176376b7e353fc7e587820c79f87e738bb2b6ff832e72da868b"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.55/cvx-darwin-x64.tar.gz"
      sha256 "5c026e39a5fc5b05539f35a4c1c87543897be11e7f98682f25657fdcf374d43a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.55/cvx-linux-arm64.tar.gz"
      sha256 "9e5ca3b75d5cb3efab6108721dc37588300dc8b6fd687d3580de2e4510691ff3"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.55/cvx-linux-x64.tar.gz"
      sha256 "66b9807f326732c735e2f64143ffff47c703dcfaed5898b537b161cf4aa42ca6"
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
