class DevProxyBeta < Formula
  proxyVersion = "0.21.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "2226967676C1619337538425F770F22CF2641DDCEA1708EB1E7B238892840977"
  else
    proxyArch = "osx-x64"
    proxySha = "5879BAB6DF7DAE67E1859890D4F1F7B316DA774BA1C774CD30F8E417EE23D363"
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