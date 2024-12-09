class DevProxyBeta < Formula
  proxyVersion = "0.24.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "6FAF29B3E9FBAEC3B3CB7B7CF8C3BDF52A7DFEADA20E07E5687CE70FE5F369B1"
  else
    proxyArch = "osx-x64"
    proxySha = "4E74AD47CB7AB66042E52ED644BB823D732AC74A76C4AFE0DAAEC3C271738057"
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