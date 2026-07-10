class Envpilot < Formula
  desc "Envpilot CLI \u2014 sync and manage environment variables from the terminal"
  homepage "https://www.envpilot.dev"
  url "https://registry.npmjs.org/@envpilot/cli/-/cli-1.16.0.tgz"
  version "1.16.0"
  sha256 "8cfab20453782fa831c8d7a7ce531cb8484fbb2148cc38023396b712f0fa84a5"
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
