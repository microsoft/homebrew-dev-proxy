class DevProxyBeta < Formula
  proxyVersion = "0.18.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "54932BBEB8D8662202584DE515BBF71052D1C84EA6C4FBAE77CF8344F683A2AE"
  else
    proxyArch = "osx-x64"
    proxySha = "BE5B41FD1549250E9BB58AB1B930666ACBD73176936B25799D580F056C9343E4"
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