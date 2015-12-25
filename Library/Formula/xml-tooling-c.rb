class XmlToolingC < Formula
  desc "Provides a higher level interface to XML processing"
  homepage "https://wiki.shibboleth.net/confluence/display/OpenSAML/XMLTooling-C"
  url "https://shibboleth.net/downloads/c++-opensaml/2.5.3/xmltooling-1.5.3.tar.gz"
  sha256 "90e453deb738574b04f1f1aa08ed7cc9d8746bcbf93eb59f401a6e38f2ec9574"

  option "with-openssl", "Build with OpenSSL instead of Secure Transport"

  depends_on "pkg-config" => :build
  depends_on "log4shib"
  depends_on "xerces-c"
  depends_on "xml-security-c"
  depends_on "boost"
  depends_on "curl" => "with-openssl" if build.with? "openssl"

  def install
    ENV.O2 # Os breaks the build
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
