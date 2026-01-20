# Homebrew formula for prx CLI
#
# This file should be placed in your homebrew tap repository:
#   homebrew-tap/Formula/prx.rb
#
# Users install with:
#   brew tap ravi-technologies/tap
#   brew install prx
#
# IMPORTANT: Binaries are hosted in a separate PUBLIC release repository
# (ravi-technologies/prx-releases) to allow Homebrew downloads without source access.
# The source code remains in a private repository.

class Prx < Formula
  desc "AI-powered code review CLI"
  homepage "https://github.com/ravi-technologies/prx"
  version "0.1.0"
  license "Proprietary"

  # Binaries are downloaded from the public release repository
  # This allows users to install via Homebrew without access to the private source repo
  # Currently only Apple Silicon (arm64) builds available
  # Intel builds require paid GitHub runners
  on_macos do
    on_arm do
      url "https://github.com/ravi-technologies/prx-releases/releases/download/v#{version}/prx-#{version}-macos-arm64.tar.gz"
      sha256 "e95767782f95262232572a230e8252eb23956684b76a8f9a7cd2f5094197e900"
    end

    # TODO: Re-enable when Intel builds available
    # on_intel do
    #   url "https://github.com/ravi-technologies/prx-releases/releases/download/v#{version}/prx-#{version}-macos-x86_64.tar.gz"
    #   sha256 "REPLACE_WITH_ACTUAL_SHA256_FOR_X86_64"
    # end
  end

  def install
    # One-folder mode: entire prx folder is extracted, copy the binary
    bin.install "prx"
  end

  def caveats
    <<~EOS
      prx supports OpenAI and Anthropic. Set one of these API keys:
        export OPENAI_API_KEY="your-key"      # For OpenAI
        export ANTHROPIC_API_KEY="your-key"   # For Anthropic

      Add to your shell profile (~/.zshrc or ~/.bashrc) for persistence.

      Get started:
        prx                     # Review latest commit
        prx --staged            # Review staged changes
        prx --provider anthropic  # Explicit provider
    EOS
  end

  test do
    assert_match "prx #{version}", shell_output("#{bin}/prx --version")
  end
end
