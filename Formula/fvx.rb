class Fvx < Formula
  desc "Per-project Flutter SDK switching that follows the version each folder pins"
  homepage "https://github.com/rafay99-epic/fvx"
  version "0.7"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh, do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.7/fvx-darwin-arm64.tar.gz"
      sha256 "198b9ba637b6b4c8aeadbcde2aa9ad4e5ac974dc1afac3c79566ef714cae4b8b"
    end
    on_intel do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.7/fvx-darwin-x64.tar.gz"
      sha256 "90ae8238170ffe5d02d61f3e9f4f973c2068328f97c14edb22aa052413ea0c98"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.7/fvx-linux-arm64.tar.gz"
      sha256 "303c18384d306491bdf5c4e84b78b464846ea242024e91a0e06673111a1826a7"
    end
    on_intel do
      url "https://github.com/rafay99-epic/fvx/releases/download/v0.7/fvx-linux-x64.tar.gz"
      sha256 "669a497a08df713c2b06fd93e81becf0d62d78e909b87f47ac7fff7f7e594b86"
    end
  end

  def install
    bin.install "fvx"
    man1.install "fvx.1"
    # Tab completion out of the box: runs `fvx completions <shell>` at
    # install time and places each script where the shell expects it.
    generate_completions_from_executable(bin/"fvx", "completions")
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
