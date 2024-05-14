class DevProxyBeta < Formula
  proxyVersion = "0.18.0-beta.5"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "363AB0B7354E400AA91BF4E46A96BF659C932F6555DCC4D385B64FA98607D5AC"
  else
    proxyArch = "osx-x64"
    proxySha = "A1BD03F75E60635B63C8223AC30530C46341DC5ED4D88CB131059FF31A635153"
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