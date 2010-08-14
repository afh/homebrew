require 'formula'

class Mcabber <Formula
  url 'http://mcabber.com/files/mcabber-0.10.0.tar.bz2'
  homepage 'http://mcabber.com/'
  md5 '97faad2154a87da9329d51db957f9024'
  head 'http://mcabber.com/hg/'

  depends_on 'glib'
  depends_on 'loudmouth'
  depends_on 'gpgme'
  depends_on 'libgcrypt'
  depends_on 'aspell' => :optional
  depends_on 'enchant' => :optional
  depends_on 'libotr' => :optional
  depends_on 'libidn' => :optional

  def options
    [
      ["--enable-enchant", "Enable spell checking support via enchant"],
      ["--enable-aspell", "Enable spell checking support via aspell"],
      ["--enable-otr", "Enable support for off-the-record messages"]
    ]
  end

  def install
    args = ["--prefix=#{prefix}",
            "--disable-debug",
            "--disable-dependency-tracking"]

    args << "--enable-aspell" if ARGV.include? "--enable-aspell"
    args << "--enable-enchant" if ARGV.include? "--enable-enchant"
    args << "--enable-otr" if ARGV.include? "--enable-otr"

    system "./configure", *args
    system "make install"

    (share+'mcabber').install('mcabberrc.example')
    (share+'mcabber').install('contrib')
  end
end
