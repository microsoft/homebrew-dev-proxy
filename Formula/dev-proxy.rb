class DevProxy < Formula
  proxyVersion = "0.20.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "C0C5A40021F25F08DEBFB8E54C8003C6A676A873EE45587103381DE5E83901A9"
  else
    proxyArch = "osx-x64"
    proxySha = "A38026C3C05F1CF437313CABB3AF5006A14F919E9DE11D39C42BBA107F5365E0"
  end

  desc "Dev Proxy #{proxyVersion}"
  homepage "https://aka.ms/devproxy"
  url "https://github.com/microsoft/dev-proxy/releases/download/v#{proxyVersion}/dev-proxy-#{proxyArch}-v#{proxyVersion}.zip"
  sha256 proxySha
  version proxyVersion

  def install
    prefix.install Dir["*"]
    chmod 0555, prefix/"devproxy"
    if OS.mac?
      chmod 0555, prefix/"libe_sqlite3.dylib"
    else
      chmod 0555, prefix/"libe_sqlite3.so"
    end
    bin.install_symlink prefix/"devproxy"
  end

  test do
    assert_match proxyVersion.to_s, shell_output("#{bin}/devproxy --version")
  end

  livecheck do
    url :stable
    strategy :github_latest
  end
end