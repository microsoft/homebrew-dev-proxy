class DevProxy < Formula
  proxyVersion = "0.17.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "470B30A89B21A7AD753ED73C1FBB22AE79EE0864268BCAE465C1CF494A771152"
  else
    proxyArch = "osx-x64"
    proxySha = "AA3BAD8E09B3DCB0E6229E91494FE8380589411CCB84B2AA1C3CB31DE490914C"
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