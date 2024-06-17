class DevProxyBeta < Formula
  proxyVersion = "0.19.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "8DCD0B8032C441B9453309A7CD7EA29E6CBE5621EC08865D30F9E04FF54F64FA"
  else
    proxyArch = "osx-x64"
    proxySha = "6CE3B798A09067D5FEC35C946F126F68155BEC4D65D4029819ED545676780EB2"
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