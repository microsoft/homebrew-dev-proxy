class DevProxyBeta < Formula
  proxyVersion = "0.20.0-beta.4"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "9E58DE3E5882F5CB9144DC546D992EACB7059B0C51A8910200817D4EA02D4A22"
  else
    proxyArch = "osx-x64"
    proxySha = "FED7A00CF57686B2078ADA1DE2704C7C2F1E29450D7C0922F5E488ECF0C3C44C"
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