class DevProxy < Formula
  proxyVersion = "0.20.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "6EDCE41BD529041CFD11B47E89CE1AB4F8CF9E103BFB67B6152546D2B3F9DD9E"
  else
    proxyArch = "osx-x64"
    proxySha = "8691154143BF8DFB9BF4B67314B684548EC58ADBBCCFFAE13014E8D33F3D983A"
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