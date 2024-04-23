class DevProxyBeta < Formula
  proxyVersion = "0.17.0-beta.4"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "24FB0BD65E6BF6EEA9B9EC55C20513CE080F12A6E64EE46FFDCD8D619F072DD1"
  else
    proxyArch = "osx-x64"
    proxySha = "B27F97128F5C4BA36786871B85FA307B3888CBB7F9585006F035FDEEFA334E9C"
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