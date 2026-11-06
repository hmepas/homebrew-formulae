class Obi < Formula
  desc "Native macOS status bar for yabai"
  homepage "https://github.com/hmepas/obi"
  url "https://github.com/hmepas/obi/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "b84135b507ee52684190a1b99109c1474890fb953309cb50d999df3cfe191d9e"

  head "https://github.com/hmepas/obi.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on macos: :sonoma

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/obi"
  end

  service do
    run [opt_bin/"obi"]
    keep_alive true
    process_type :interactive
    log_path var/"log/obi.log"
    error_log_path var/"log/obi.log"
  end

  def caveats
    <<~EOS
      obi draws in the strip the hidden system menu bar leaves free:
        System Settings → Control Center → Automatically hide and show the menu bar
        ~/.yabairc: yabai -m config external_bar main:0:0
      Point yabai signals at http://localhost:7776 (see the README), then:
        brew services start obi
      Config: ~/.config/obi/config.toml (theme = "pills" | "band" | "segmented").
    EOS
  end

  test do
    assert_match "usage:", shell_output("#{bin}/obi --help")
  end
end
