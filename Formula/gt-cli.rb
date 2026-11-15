class GtCli < Formula
  desc "Stacked-PR CLI with GitHub Stack sync and optional Graphite submission"
  homepage "https://github.com/tianrendong/gt-cli"
  url "https://github.com/tianrendong/gt-cli/releases/download/v0.6.48/tianrendong-gt-cli-0.6.48.tgz"
  sha256 "28cf6c52c1c4ec4c93a18e67a809fa1716bfbca1bf45aeed711c45389fd65eb1"
  license "AGPL-3.0-only"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/gt-cli"
  end

  def caveats
    <<~EOS
      Finish setup (installs a private Node runtime under ~/.local/share/gt-cli):
        gt-cli install
      Then enable it:
        gt-cli enable --global
    EOS
  end

  test do
    assert_match "gt-cli update", shell_output("#{bin}/gt-cli --help")
  end
end
