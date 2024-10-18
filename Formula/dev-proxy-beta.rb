class DevProxyBeta < Formula
  proxyVersion = "0.22.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "516F3B249CA24E0F0ACAE82D58D788D9E307C22C717AF76E585E52AA1440307E"
  else
    proxyArch = "osx-x64"
    proxySha = "4ECE12D3789DC9369DC49FC24A8E72A789948FAEDCD1CD4675FD5F95132996C1"
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