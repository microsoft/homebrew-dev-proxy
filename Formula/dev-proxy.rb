class DevProxy < Formula
  proxyVersion = "0.23.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "EB2CC955192CF19BE13A3E1EE6530EC9F94EF9562F9C3A7E7700D9A538089908"
  else
    proxyArch = "osx-x64"
    proxySha = "D4E98371AD6D76322A12B80F42C917EB899C4ABA04783ACD82CD204259EB6953"
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