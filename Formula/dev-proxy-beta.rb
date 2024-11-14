class DevProxyBeta < Formula
  proxyVersion = "0.23.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "144D4AA1BF86DBF7D81118041EF8CF3829608C49F2CEB95D8AC795108CF39128"
  else
    proxyArch = "osx-x64"
    proxySha = "261A10F109AE3D9110FE3A1C416E58FFD75D1375DDDC8B788D283DB05286745C"
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