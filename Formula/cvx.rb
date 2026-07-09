class Cvx < Formula
  desc "Per-project Convex account switching — no deploy keys, no tokens in repos"
  homepage "https://github.com/rafay99-epic/convex-switch"
  version "0.51"
  license "MIT"

  # Standalone binaries compiled with `bun build --compile` (bundle the Bun
  # runtime, so there is no dependency to install). release.yml regenerates this
  # whole formula each release via .github/scripts/bump-formula.sh — do not
  # hand-edit the version or sha256 lines.
  on_macos do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.51/cvx-darwin-arm64.tar.gz"
      sha256 "7c80de7099b0aac4ab7da36e46d1258f0c222ef8dee235f2e666ca3f4a9780ad"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.51/cvx-darwin-x64.tar.gz"
      sha256 "248f1e846099e68a05fe34279248b4f8cf09ae7814a214d9980e442be7651f48"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.51/cvx-linux-arm64.tar.gz"
      sha256 "1c65c863e0fa316b5c607ef626cbc7e26d062250e71516ba03f03928b078b921"
    end
    on_intel do
      url "https://github.com/rafay99-epic/convex-switch/releases/download/v0.51/cvx-linux-x64.tar.gz"
      sha256 "a5c0692f9226b98962445507420db15236b2b172ff38728e30f16ab17a8dda5d"
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
