class DevProxyBeta < Formula
  proxyVersion = "0.19.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "906BC8431170BC2DF374B5C743139D18E2FBFC968971CAD214AA788D20AF4F39"
  else
    proxyArch = "osx-x64"
    proxySha = "9093AB738E7153DE665FE885A5C2FCD78E3532E8F471A450D086F38DEAE8C026"
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