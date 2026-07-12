class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.56"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.56/cvx-darwin-arm64.tar.gz"
      sha256 "bee89a403789864aed20ceefcc2b0a625c2c01149bb1458462c7941c9b8ee791"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.56/cvx-darwin-x64.tar.gz"
      sha256 "b6eab999b6e7538c7e80c65537783a95a2cea9931079431695ba18cf37011b36"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.56/cvx-linux-arm64.tar.gz"
      sha256 "7b9b90cc975bb12226ec00b31a148607a0dea5f6d73933962e3882f1787be072"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.56/cvx-linux-x64.tar.gz"
      sha256 "a5fc799b7401add82a0251a0bcb874f2b9266f6a88832f39f13ac39a8d912204"
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
