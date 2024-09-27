class DevProxy < Formula
  proxyVersion = "0.21.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "EF4D727C223669F7B84BE83D074DF700F62EA2508A70E1371DD1271A37C4CD3C"
  else
    proxyArch = "osx-x64"
    proxySha = "6211AE1A044B963AB5ED23C5920FE13923742C1AE651797037202113FA259094"
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
    url :stable
    strategy :github_latest
  end
end