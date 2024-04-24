class DevProxy < Formula
  proxyVersion = "0.17.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "86F48C9BE6FB47EF8CCA8AFBD20C2E42E801DD69811581092260B82875A7E1F8"
  else
    proxyArch = "osx-x64"
    proxySha = "B86E42D278D65E15CA1E0CD88D1A119111107064563B65043DF59D058F51E6C8"
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