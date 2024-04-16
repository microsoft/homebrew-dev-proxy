class DevProxyBeta < Formula
  proxyVersion = "0.17.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "24031CA841F0390D73BF0570D7AAF507ED76717794F7F5F83ADE4111C6570A50"
  else
    proxyArch = "osx-x64"
    proxySha = "4490E2BB106F4BE8D713CD77214B5A6E3C5C007A3DD69B57B2658BA600E59F75"
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
    url :head
    regex(/^v(.*)$/i)
  end
end