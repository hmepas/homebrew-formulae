class Grappa < Formula
  include Language::Python::Virtualenv

  desc "AI-augmented Telegram client"
  homepage "https://github.com/hmepas/grappa"
  url "https://github.com/hmepas/grappa/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "abd95f306752ca57b5950623a648ac9e61f2c41979f9ceb0cd78f840ac349d22"

  head "https://github.com/hmepas/grappa.git", branch: "main"

  depends_on "python@3.13"

  def install
    virtualenv_create(libexec, "python3.13")
    # Install grappa and let pip resolve its dependencies from PyPI
    system libexec/"bin/python", "-m", "pip", "install", "--no-cache-dir", buildpath.to_s
    bin.install_symlink libexec/"bin/grappa"
  end

  def caveats
    <<~EOS
      grappa needs Telegram API credentials (https://my.telegram.org/apps).
      On first run it will ask for them and save the answers to
      ~/.config/grappa/config.env. Environment variables and a ./.env file
      in the working directory take priority over the global config.

      Session and cache files are created relative to the current working
      directory (sessions/, data/, downloads/), so run grappa from a
      dedicated directory.
    EOS
  end

  test do
    assert_match "AI-augmented Telegram client", shell_output("#{bin}/grappa --help")
  end
end
