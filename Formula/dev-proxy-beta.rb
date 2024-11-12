class DevProxyBeta < Formula
  proxyVersion = "0.23.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "9F0411F096C03F4232D6F700C1A43D7B568AAFF76E650C56C13AEB58B3FE1716"
  else
    proxyArch = "osx-x64"
    proxySha = "7EF9E9EA060121F3C51C9971AEFB11F9776EAC7958AF78BFC325C95C96E96FF4"
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