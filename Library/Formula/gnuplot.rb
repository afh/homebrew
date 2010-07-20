require 'formula'

class Gnuplot <Formula
  url 'http://downloads.sourceforge.net/project/gnuplot/gnuplot/4.4.0/gnuplot-4.4.0.tar.gz'
  homepage 'http://www.gnuplot.info'
  md5 'e708665bd512153ad5c35252fe499059'

  depends_on 'pkg-config'
  depends_on 'readline'
  depends_on 'gd' unless ARGV.include? "--nogd"
  depends_on 'pdflib-lite' if ARGV.include? "--pdf"
 #depends_on 'wxmac'
  depends_on 'jpeg' => :optional
  depends_on 'aquaterm' => :optional

  def install
    ENV.x11
    args = ["--disable-debug", "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--with-readline=#{prefix}",
            "--enable-datastrings",
            "--enable-histograms",
            "--disable-wxwidgets"]
    args << "--without-lua" if ARGV.include? "--without-lua"

    system "./configure", *args
    system "make install"
  end

  def caveats
    <<-EOF
    If you want support for aquaterm on Mac OS X,
    check the aquaterm caveats beforehand.
    EOF
  end
end
