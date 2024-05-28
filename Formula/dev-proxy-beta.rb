class DevProxyBeta < Formula
  proxyVersion = "0.18.0-beta.8"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "2E616E6499611EF1A11F34EF02890CB261039F31B20359D3E1525310AC2EB385"
  else
    proxyArch = "osx-x64"
    proxySha = "62CB1810D1D51D1F1681D01DD8AD7F2C197DFDA8F24A03CCCF93BB139A19A10F"
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