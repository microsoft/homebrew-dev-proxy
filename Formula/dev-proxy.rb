class DevProxy < Formula
  proxyVersion = "0.16.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "B7F68397ED93A9C08ED7F6CDB3D1CAF909389FC4CA58D4D983F6DC8105420B6B"
  else
    proxyArch = "osx-x64"
    proxySha = "BF9922F08F94E8183418FF04A4C91E3D07180D42AC405FB38208FE2614CBBFBE"
  end

  desc "Dev Proxy #{proxyVersion}"
  homepage "https://aka.ms/devproxy"
  url "https://github.com/microsoft/dev-proxy/releases/download/v#{proxyVersion}/dev-proxy-#{proxyArch}-v#{proxyVersion}.zip"
  sha256 proxySha
  version proxyVersion

  def install
    prefix.install Dir["*"]
    chmod 0555, prefix/"devproxy"
    if OS.mac?
      chmod 0555, prefix/"libe_sqlite3.dylib"
    else
      chmod 0555, prefix/"libe_sqlite3.so"
    end
    bin.install_symlink prefix/"devproxy"
  end

  test do
    assert_match proxyVersion.to_s, shell_output("#{bin}/devproxy --version")
  end

  livecheck do
    url :stable
    strategy :github_latest
  end
end