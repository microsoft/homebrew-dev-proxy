class DevProxy < Formula
  proxyVersion = "0.22.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "63909C7EBBD370C8B89E12E332794D647C513304B82778F8A841135EA74A8685"
  else
    proxyArch = "osx-x64"
    proxySha = "38C3277BC6CF84CBE3AAD550767CF6FF3772113236E9F61DB1051090384358CC"
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