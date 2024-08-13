class DevProxyBeta < Formula
  proxyVersion = "0.20.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "18A28815E398DFE440A1B7D40F32A0C9CDEEA96016A2D12D641E6ED9C1A1DCB8"
  else
    proxyArch = "osx-x64"
    proxySha = "122B292F17DD7AE5529704996EA6A0E859311787A1CAE41B86872D42FDBA9DAF"
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