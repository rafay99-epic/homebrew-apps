class Cvx < Formula
  desc "Per-project Convex account switching without deploy keys or tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.61"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.61/cvx-darwin-arm64.tar.gz"
      sha256 "89e63b7645f6cbf007b7931a02377322b071eeca18b4805483017bf0c58e5eac"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.61/cvx-darwin-x64.tar.gz"
      sha256 "4efda1a4f21631daba78ce05f5351c225fd9644180c5f680de46766e752b317f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.61/cvx-linux-arm64.tar.gz"
      sha256 "224571aa8a02ec5495fe953d404772a89673da0e531ead12548e8ad07de18c45"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.61/cvx-linux-x64.tar.gz"
      sha256 "bd967c0dfb4a8679ca627c87d79f1d2f94be151f449839f038e6d47c81c37c8f"
    end
  end

  def install
    bin.install "cvx"
    man1.install "cvx.1"
    # Tab completion out of the box: runs `cvx completions <shell>` at
    # install time and places each script where the shell expects it.
    generate_completions_from_executable(bin/"cvx", "completions")
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
