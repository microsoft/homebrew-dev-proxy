class DevProxy < Formula
  proxyVersion = "0.16.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "2404e64a1210789333d7df291ae9de951401b6efdafd2299167cf1046965c861"
  else
    proxyArch = "osx-x64"
    proxySha = "a34935718e4e907adffb47849fb2b3e55a379be506f2ce3b800d11cd986e9b20"
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