class DevProxyBeta < Formula
  proxyVersion = "0.20.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "6779608AA9217225FB4358AA74A17BE93BB8ED8CF4A5A501B873F473E648434A"
  else
    proxyArch = "osx-x64"
    proxySha = "E0ADD73F22E95DE43971E1D588473D7B5B7911C0A18369331672438F6ABAC998"
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