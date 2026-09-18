class Fvx < Formula
  desc "Per-project Flutter SDK switching. Run flutter in any folder, get the version that folder pins"
  homepage "https://github.com/rafay99-epic/fvx"
  version "0.2"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh, do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.2/fvx-darwin-arm64.tar.gz"
      sha256 "eacdc702539597d75d91e92a41078ec15faa043fdcafdf859d1a650f9c0d1a1c"
    end
    on_intel do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.2/fvx-darwin-x64.tar.gz"
      sha256 "518de208e10f711c487f5246c8dd412e9ae384b9e0d1500944ff2d4af605b798"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.2/fvx-linux-arm64.tar.gz"
      sha256 "99e4faa323cb106a1ab406a0d57685eb465e41c8875f94c30493d1d6f2c0b115"
    end
    on_intel do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.2/fvx-linux-x64.tar.gz"
      sha256 "810582247f235b21689eb85c947f70a2c5e21eb94b80af128c513d447e82ed7a"
    end
  end

  def install
    bin.install "fvx"
    man1.install "fvx.1"
    # Tab completion out of the box: runs `fvx completions <shell>` at
    # install time and places each script where the shell expects it.
    generate_completions_from_executable(bin/"fvx", "completions", shells: [:zsh, :bash, :fish])
  end

  def caveats
    <<~CAVEATS
      One-time setup to enable automatic per-project Flutter SDK switching:

        fvx setup     # writes the shims, adds them to PATH

      Then restart your shell.

      Pin a project with:  fvx use <version>
    CAVEATS
  end

  test do
    assert_match "Flutter", shell_output("#{bin}/fvx help")
  end
end
