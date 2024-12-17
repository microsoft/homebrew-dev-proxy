class DevProxyBeta < Formula
  proxyVersion = "0.24.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "AB076880D6AF49E416887B1E2582D734D82C2DC8D4A84DE42E407B52A450A6E3"
  else
    proxyArch = "osx-x64"
    proxySha = "12E517B5BE3B2173C0562F4190D9B12C4FD6C399F06F92BACB0F4AEBBACAE7C0"
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