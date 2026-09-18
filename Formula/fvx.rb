class Fvx < Formula
  desc "Per-project Flutter SDK switching. Run flutter in any folder, get the version that folder pins"
  homepage "https://github.com/rafay99-epic/fvx"
  version "0.1"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh, do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.1/fvx-darwin-arm64.tar.gz"
      sha256 "54e898ef9295e8c571f9b7ff07ef4083af1088ad15973eb47a022413cf9bd744"
    end
    on_intel do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.1/fvx-darwin-x64.tar.gz"
      sha256 "1ebca15640d5ff7870d129048ffdde47d29fb2bed0fb5bc81f21a28479726de5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.1/fvx-linux-arm64.tar.gz"
      sha256 "188156ee31b0aa9b07f2a1d5c8d5c9831571b88c5e8297996fc0f8b6fd08d75a"
    end
    on_intel do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.1/fvx-linux-x64.tar.gz"
      sha256 "31d0d10bce3ce3a87add08b9779fbd83c9fb0ef79d645bc51cccf88efb7b7c96"
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
