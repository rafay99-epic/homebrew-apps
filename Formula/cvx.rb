class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.52"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.52/cvx-darwin-arm64.tar.gz"
      sha256 "169230b80a282bbdb79c800bbc3cacb11a85735dd49b5a91955952d383104e5e"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.52/cvx-darwin-x64.tar.gz"
      sha256 "d16e9b66f9090d786530e708fbc6a746c641d3516f50141dd1812bc73c4dacf8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.52/cvx-linux-arm64.tar.gz"
      sha256 "feff2bfd864c4ecd84663e6a811b9a58fed9661c29c878597534106726bda4f5"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.52/cvx-linux-x64.tar.gz"
      sha256 "587b2ec181585f441d22372ae5529555906e6ca1ebb8f940396366ce55edce8b"
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
