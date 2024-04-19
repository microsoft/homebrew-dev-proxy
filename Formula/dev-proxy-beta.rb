class DevProxyBeta < Formula
  proxyVersion = "0.17.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "894D8857E6325E878B28E62ECBF5D620A152F299BC1B06CA1EDA1F0509771FB8"
  else
    proxyArch = "osx-x64"
    proxySha = "67BEA923659CD33E346A6A72517B7B48E189D7B1D7F57217AD9CA8135F1710C7"
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