class DevProxyBeta < Formula
  proxyVersion = "0.22.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "A1FB4BCD6DE446F936E64AAE2276228F6379EFA862D6AD1D40BD513D9D4F1116"
  else
    proxyArch = "osx-x64"
    proxySha = "6B6558C328365AAAE6E59BE0E41813833602D598A31B3CF61470241725BAFF2B"
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