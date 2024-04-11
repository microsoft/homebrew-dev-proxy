class DevProxyBeta < Formula
  proxyVersion = "0.16.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "81407463d20ad68afe2b898b4f2fdac19ccf36faba4659927c02f31934ad6b3a"
  else
    proxyArch = "osx-x64"
    proxySha = "d566132a9b0f83f805e58f14d45183a2e6839bae66d2f97babca7d15f3cf445d"
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
    url :head
    regex(/^v(.*)$/i)
  end
end