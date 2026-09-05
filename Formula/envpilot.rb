class Envpilot < Formula
  desc "Envpilot CLI \u2014 sync and manage environment variables from the terminal"
  homepage "https://www.envpilot.dev"
  url "https://registry.npmjs.org/@envpilot/cli/-/cli-1.23.1.tgz"
  version "1.23.1"
  sha256 "894cc073a5b2137132af3eaef207d412ad5167aa61f49248e2754a1666cdd47f"
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
