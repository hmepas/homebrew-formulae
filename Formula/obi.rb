class Obi < Formula
  desc "Native macOS status bar for yabai"
  homepage "https://github.com/hmepas/obi"
  url "https://github.com/hmepas/obi/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "572d89355b75edcfac1efec8a47e5ca2d96c59ae170a653d8537060c3af8cdc6"

  head "https://github.com/hmepas/obi.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on macos: :sonoma

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    # Location access (needed for the Wi-Fi name) is only granted to app bundles started by
    # their real path, so bin/obi is an exec script rather than a symlink.
    system "scripts/bundle.sh", ".build/release/obi", prefix/"obi.app"
    bin.write_exec_script prefix/"obi.app/Contents/MacOS/obi"
  end

  service do
    run [opt_prefix/"obi.app/Contents/MacOS/obi"]
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
      The wifi widget needs Location access to read the network name (macOS 27.2+):
        allow the prompt on first start and after each upgrade, or enable obi in
        System Settings → Privacy & Security → Location Services.
    EOS
  end

  test do
    assert_match "usage:", shell_output("#{bin}/obi --help")
  end
end
