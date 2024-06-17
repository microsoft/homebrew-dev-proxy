class DevProxyBeta < Formula
  proxyVersion = "0.19.0-beta.4"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "81FE2F942FCDAF6E2AFC9B2F40840888168D52FB5D3104C1849F25A548DA2FA6"
  else
    proxyArch = "osx-x64"
    proxySha = "D6B55E6A1A0E930385AEE25063829FFA0AA085E85D498AD5A4672C29E2605228"
  end

  desc "Dev Proxy #{proxyVersion}"
  homepage "https://aka.ms/devproxy"
  url "https://github.com/microsoft/dev-proxy/releases/download/v#{proxyVersion}/dev-proxy-#{proxyArch}-v#{proxyVersion}.zip"
  sha256 proxySha
  version proxyVersion

  def install
    prefix.install Dir["*"]
    chmod 0555, prefix/"devproxy-beta"
    if OS.mac?
      chmod 0555, prefix/"libe_sqlite3.dylib"
    else
      chmod 0555, prefix/"libe_sqlite3.so"
    end
    bin.install_symlink prefix/"devproxy-beta"
  end

  test do
    assert_match proxyVersion.to_s, shell_output("#{bin}/devproxy-beta --version")
  end

  livecheck do
    url :head
    regex(/^v(.*)$/i)
  end
end