class DevProxyBeta < Formula
  proxyVersion = "0.18.0-beta.4"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "1A77FA95B2798A1E4DF714C53528B26B66D324EB3E5A0DF32BFF710A51DA844B"
  else
    proxyArch = "osx-x64"
    proxySha = "1206E7FC692778A7B485F83910257CAEB382B2B2D8FB3394FDCF676C459447CB"
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