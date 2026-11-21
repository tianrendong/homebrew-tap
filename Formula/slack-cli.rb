class SlackCli < Formula
  desc "CLI for searching and reading Slack"
  homepage "https://github.com/tianrendong/slack-cli"
  url "https://github.com/tianrendong/slack-cli/releases/download/v0.1.1/slack-cli-0.1.1.tgz"
  sha256 "d2bfbb15793eea9d6a5caf9043f28c97f658fa1168da8009899f732de2b9161e"

  depends_on "bun"

  def install
    libexec.install "slack.js"
    pkgshare.install ".env.example"
    (bin/"slack").write <<~SH
      #!/bin/bash
      exec "#{formula_opt_bin("bun")}/bun" --no-env-file "#{libexec}/slack.js" "$@"
    SH
    bin.install_symlink "slack" => "slack-cli"
  end

  def caveats
    <<~EOS
      Authenticate with a user token:
        slack auth token <xoxp-token>
      Or configure OAuth app credentials in ~/.config/slack-cli/.env
      (template: #{opt_pkgshare}/.env.example), then run:
        slack auth login
    EOS
  end

  test do
    assert_match "slack download <file-id|slack-file-url>", shell_output("#{bin}/slack download --help")
  end
end
