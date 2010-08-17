require 'formula'

class Gd <Formula
  url "http://www.libgd.org/releases/gd-2.0.36RC1.tar.gz"
  homepage "http://www.libgd.org"
  head "http://bitbucket.org/pierrejoye/gd-libgd/"
  md5 "39ac48e6d5e0012a3bd2248a0102f209"

  depends_on 'jpeg' => :recommended

  def patches
    DATA
  end

  def install
    ENV.libpng
    inreplace "gdlib.pc", "PREFIX", prefix
    system "./configure", "--prefix=#{prefix}", "--with-freetype=/usr/X11"
    system "make install"
    (lib+'pkgconfig').install "gdlib.pc"
    # Other software may look for gd or libgd instead of gdlib using pkg-config
    # symlinking the .pc file remedies the problem
    #File.symlink (lib+'pkgconfig'+'gdlib.pc'), (lib+'pkgconfig'+'gd.pc')
  end
end

__END__
diff --git a/gdlib.pc b/gdlib.pc
new file mode 100644
index 0000000..91fe011
--- /dev/null
+++ b/gdlib.pc
@@ -0,0 +1,15 @@
+prefix=PREFIX
+exec_prefix=${prefix}
+libdir=/${exec_prefix}/lib
+includedir=/${prefix}/include
+bindir=/${prefix}/bin
+ldflags=  -L/${prefix}/lib
+
+
+Name: gd
+Description: A graphics library for quick creation of PNG or JPEG images
+Version: 2.0.36RC1
+Requires:
+Libs: -L${libdir} -lgd
+Libs.private: -lXpm -lX11 -ljpeg -lfontconfig -lfreetype -lpng12 -lz -lm
+Cflags: -I${includedir}
