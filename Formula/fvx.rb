class Fvx < Formula
  desc "Per-project Flutter SDK switching. Run flutter in any folder, get the version that folder pins"
  homepage "https://github.com/rafay99-epic/fvx"
  version "0.3"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh, do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.3/fvx-darwin-arm64.tar.gz"
      sha256 "7155f1a295cfb9aece3eff2c61235b121028e25a14c7b21232a64cb0c768fdfc"
    end
    on_intel do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.3/fvx-darwin-x64.tar.gz"
      sha256 "3963d3789313e1ced92059c3fa7ef0956d3c45d9a34a12b01f2c902ccd07fa19"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.3/fvx-linux-arm64.tar.gz"
      sha256 "89676d010970e2b9a1728813e64c4e6934cec2eff30df29a943026496b649e30"
    end
    on_intel do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.3/fvx-linux-x64.tar.gz"
      sha256 "bb1f3118c76b2072059206439c1fd3ad81194f38584625b6c3f7f5280c3291cb"
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
