class DevProxyBeta < Formula
  proxyVersion = "0.18.0-beta.7"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "F00BF2A7EB096998E376360636691A734A9B4AB487FC7A1FBC8511DC410AC4D6"
  else
    proxyArch = "osx-x64"
    proxySha = "232710C0C838169AF34CF88BD1E06A025C1D19485B07596B3A12958FB1307EA2"
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