class DevProxyBeta < Formula
  proxyVersion = "0.17.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "97F0039789BEFD0BF6231DE2568D0C4F13D9E17C741C68252B2268DA05B5862F"
  else
    proxyArch = "osx-x64"
    proxySha = "272449E9EE71B39940B8FB4705CF176EF56F717DAFD3A6F8CE09B2B361927E9A"
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
    url :head
    regex(/^v(.*)$/i)
  end
end