class DevProxy < Formula
  proxyVersion = "0.19.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "B0E6194BEC31E73A38ABCDD9CD356D8EE1DD928EBEBF0D3ECCB3CC44722A68BC"
  else
    proxyArch = "osx-x64"
    proxySha = "2ABCFB70331F508D957B8810484199F5B94659347F1E0EC37A28DCDE6C289DDD"
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