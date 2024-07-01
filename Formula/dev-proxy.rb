class DevProxy < Formula
  proxyVersion = "0.19.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "6CD1C51592128ECF601F18A08126D9BB31F5B9C453203E37BBC71FBA88E16C9A"
  else
    proxyArch = "osx-x64"
    proxySha = "E29DE52213680BB67BE582A60AA49AF5F4249CFB681D5EA1736798429E6E3399"
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