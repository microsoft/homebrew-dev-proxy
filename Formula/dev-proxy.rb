class DevProxy < Formula
  proxyVersion = "0.18.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "F7865262FE1E928AC45F6B13BECAAC90068E5865CB8C48A53318E3FA6393DFE8"
  else
    proxyArch = "osx-x64"
    proxySha = "A1910C631A821401EA0C9BCB8B5603EF97FA3054AA454AE7A72E1772673D5180"
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