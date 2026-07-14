class Grappa < Formula
  include Language::Python::Virtualenv

  desc "AI-augmented Telegram client"
  homepage "https://github.com/hmepas/grappa"
  url "https://github.com/hmepas/grappa/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7a5b43e15ea27d0a73213ea12d88d4be49c184966a8b47420d237019e484210d"

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
      grappa needs Telegram API credentials, provided via environment variables
      or a .env file in the directory you run it from:

        TELEGRAM_API_ID=...
        TELEGRAM_API_HASH=...
        TELEGRAM_PHONE_NUMBER=...   # optional

      Get credentials at https://my.telegram.org/apps.

      Session and cache files are created relative to the current working
      directory (sessions/, data/, downloads/), so run grappa from a
      dedicated directory.
    EOS
  end

  test do
    assert_match "AI-augmented Telegram client", shell_output("#{bin}/grappa --help")
  end
end
