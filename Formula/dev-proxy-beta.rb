class DevProxyBeta < Formula
  proxyVersion = "0.20.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "CD4D8DC4E040B530EDB5C9FA9380ADB894DCF1231A2248CCAB3E2B39EFC78681"
  else
    proxyArch = "osx-x64"
    proxySha = "838323762FD9D5768BF841FF01524B6E89144B5D6DB660857CE7E6B9732EC0A5"
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