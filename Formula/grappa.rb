class Grappa < Formula
  include Language::Python::Virtualenv

  desc "Telegram client CLI"
  homepage "https://github.com/hmepas/grappa"
  url "https://github.com/hmepas/grappa/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "01f45483b05cb368e6e44cc39c674817d7930132054b002e9e4041d4fd117909"

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

      Session, cache and downloaded media live in ~/.grappa/data/
      (override with GRAPPA_DATA_DIR, GRAPPA_SESSION_DIR, GRAPPA_DOWNLOADS_DIR).
    EOS
  end

  test do
    # Substring matches help output both before and after the rebranding
    assert_match "Telegram client", shell_output("#{bin}/grappa --help")
  end
end
