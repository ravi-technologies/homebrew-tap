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
      sha256 "61d624a7d2b76f2cf8b019f270b5c42d0be2a0d5c537604f6ce78b79cf522308"
    end
  end

  def install
    bin.install "ravi"
  end

  def caveats
    <<~EOS
      Ravi supports OpenAI and Anthropic. Set one of these API keys:
        export OPENAI_API_KEY="your-key"      # For OpenAI
        export ANTHROPIC_API_KEY="your-key"   # For Anthropic

      Get started:
        ravi review              # Review latest commit
        ravi review --staged     # Review staged changes
        ravi review --provider anthropic  # Explicit provider
    EOS
  end

  test do
    assert_match "ravi #{version}", shell_output("#{bin}/ravi version")
  end
end
