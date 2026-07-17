class Envpilot < Formula
  desc "Envpilot CLI \u2014 sync and manage environment variables from the terminal"
  homepage "https://www.envpilot.dev"
  url "https://registry.npmjs.org/@envpilot/cli/-/cli-1.18.0.tgz"
  version "1.18.0"
  sha256 "c62a5d6c0c4c6aa4da830006dc1d4d1d60067256869def37d8c2f5f3e85a8575"
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
