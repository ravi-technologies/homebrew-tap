# Homebrew formula for Ravi CLI
class Ravi < Formula
  desc "AI-powered code review CLI"
  homepage "https://github.com/ravi-technologies/ravi"
  version "0.1.0"
  license "Proprietary"

  # Currently only Apple Silicon (arm64) builds available
  on_macos do
    on_arm do
      url "https://github.com/ravi-technologies/ravi-releases/releases/download/v#{version}/ravi-#{version}-macos-arm64.tar.gz"
      sha256 "05de48aada9740e5099b02c4c77d7c16a8a63050fd316e16190bbad11c9c061a"
    end
  end

  def install
    bin.install "ravi"
  end

  def caveats
    <<~EOS
      Ravi requires an OpenAI API key to function.
      Set your API key:
        export OPENAI_API_KEY="your-api-key"
      Get started:
        ravi review              # Review latest commit
        ravi review --staged     # Review staged changes
    EOS
  end

  test do
    assert_match "ravi #{version}", shell_output("#{bin}/ravi version")
  end
end
