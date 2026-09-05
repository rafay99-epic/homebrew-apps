class Envpilot < Formula
  desc "Envpilot CLI \u2014 sync and manage environment variables from the terminal"
  homepage "https://www.envpilot.dev"
  url "https://registry.npmjs.org/@envpilot/cli/-/cli-1.23.0.tgz"
  version "1.23.0"
  sha256 "634deb3f73caaf5409e715d28bebc24da4ac66dd3be498472a66c4d20a0c73ab"
  license "UNLICENSED"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/envpilot"
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/envpilot --version")
  end
end
