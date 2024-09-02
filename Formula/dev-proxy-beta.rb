class DevProxyBeta < Formula
  proxyVersion = "0.21.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "B30974D581FF42A20AC00580C84E764D61CFED597B8B890FA87B2BE14B185004"
  else
    proxyArch = "osx-x64"
    proxySha = "A25BAF9E6A0401C887251AB89A755FFF5A5AE8E8FE1E6D507E178A0401976445"
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