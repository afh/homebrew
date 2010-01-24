require 'formula'

class Gnuplot <Formula
  @url='http://downloads.sourceforge.net/project/gnuplot/gnuplot/4.4.0-rc1/gnuplot-4.4.0-rc1.tar.gz'
  @homepage='http://www.gnuplot.info/'
  @md5='b7be3d0e812dc309639a28dd1e5a9172'

  depends_on 'readline'
 #depends_on 'wxmac'
  depends_on 'jpeg' => :optional
  depends_on 'gd' => :optional
  depends_on 'aquaterm' => :optional

  def install
    configure_args = [
        "--prefix=#{prefix}",
        "--disable-debug",
        "--disable-dependency-tracking",
        "--disable-wxwidgets",
        "--with-readline=#{prefix}/lib",
        "--enable-datastrings",
        "--enable-histograms"
    ]
    system "./configure", *configure_args
    system "make install"
  end

  def caveats
    <<-EOF
    If you want support for aquaterm on Mac OS X,
    check the aquaterm caveats beforehand.
    EOF
  end
end
