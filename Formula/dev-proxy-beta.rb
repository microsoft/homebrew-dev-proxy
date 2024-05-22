class DevProxyBeta < Formula
  proxyVersion = "0.18.0-beta.6"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "6CFD2B73543ADC806990ED009011ADBCF39B908C56274CC33770BA48469D3332"
  else
    proxyArch = "osx-x64"
    proxySha = "91D72CC0F6860249316069D59925CEC3634989017E8111090AFBF46B51B2FE51"
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