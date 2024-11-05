class DevProxyBeta < Formula
  proxyVersion = "0.23.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "778EC07EDAEFB3C430B647D4D6FCEFC3350A918E8C4E00E91287F8521B0550C2"
  else
    proxyArch = "osx-x64"
    proxySha = "9F63A75A9488B77C1EAAE7C9649A08C788678E838BE36337144ECC8929E42BB4"
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