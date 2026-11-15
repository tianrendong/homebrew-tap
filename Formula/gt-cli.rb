class GtCli < Formula
  desc "Stacked-PR CLI with GitHub Stack sync and optional Graphite submission"
  homepage "https://github.com/tianrendong/graphite"
  url "https://github.com/tianrendong/graphite/releases/download/v0.6.47/tianrendong-graphite-0.6.47.tgz"
  sha256 "e48f3766cb5f1aeacbf2af2c0f62b794c7bbb2cdd322d5e842166f984c0e555a"
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
