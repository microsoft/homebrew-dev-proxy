class DevProxyBeta < Formula
  proxyVersion = "0.21.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "3C8AE8FAD8AFC11574C61677734A4C8AAF1BE3856139132FC20FAFAC4A45FCC5"
  else
    proxyArch = "osx-x64"
    proxySha = "C4550ACEFF19B0D67A8A969787260796A2E024F99C446F6E0AF1B39780F43A9D"
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