class DevProxyBeta < Formula
  proxyVersion = "0.19.0-beta.5"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "FDFE0A565168FA7C7FCFE4DBD3E4122F2AE7724ACEB2AF639E3BD0D942A4777D"
  else
    proxyArch = "osx-x64"
    proxySha = "76A7C2DC81FAB94EA4039D64AD50A046C2FE5DA9EE4360A4E932016220CB67B9"
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