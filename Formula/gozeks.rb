class Gozeks < Formula
  desc "Two-way sync of a local folder with an S3 bucket"
  homepage "https://github.com/hmepas/gozeks"
  url "https://github.com/hmepas/gozeks/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "c3d59cfe3c32d4ccd77f9fb8cc426253dd8446580fa7676bc2220b51efe66ceb"

  head "https://github.com/hmepas/gozeks.git", branch: "main"

  depends_on "go" => :build

  def install
    # The macOS watcher (FSEvents) needs cgo; without it notify falls back to kqueue (one fd per file).
    ENV["CGO_ENABLED"] = OS.mac? ? "1" : "0"
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/gozeks"
  end

  service do
    run [opt_bin/"gozeks", "run"]
    keep_alive true
    log_path var/"log/gozeks.log"
    error_log_path var/"log/gozeks.log"
  end

  def caveats
    <<~EOS
      Config: ~/.config/gozeks/config.toml (see deploy/config.example.toml in the repo).
      Secrets (S3 keys, relay token): ~/.config/gozeks/env, mode 0600; gozeks reads it itself.
      Seed or fetch the folder once with `gozeks push` / `gozeks pull`, then:
        brew services start gozeks
    EOS
  end

  test do
    assert_match "usage: gozeks", shell_output("#{bin}/gozeks 2>&1", 2)
  end
end
