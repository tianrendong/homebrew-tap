class SlackCli < Formula
  desc "CLI for searching and reading Slack"
  homepage "https://github.com/tianrendong/slack-cli"
  url "https://github.com/tianrendong/slack-cli/releases/download/v0.1.0/slack-cli-0.1.0.tgz"
  sha256 "352988c82846dcaa7c8ae7fb4ae44f911a560175f6c3b85b8a940003dfafbe7b"

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
    assert_match "slack auth status", shell_output("#{bin}/slack --help")
  end
end
