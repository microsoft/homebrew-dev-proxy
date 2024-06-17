class DevProxyBeta < Formula
  proxyVersion = "0.19.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "35AE73EFF73E37CF1C1E1CFF64C44FA8827F212160F26E2926D017DA9337318B"
  else
    proxyArch = "osx-x64"
    proxySha = "0F721BFC20F220BDCFA89B9C8F3115C34C6DC524E1C1352BCEA6CA74DF592474"
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