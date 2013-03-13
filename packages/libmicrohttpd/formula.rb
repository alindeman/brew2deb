require 'formula'

class Libmicrohttpd < DebianFormula
  homepage 'http://www.gnu.org/software/libmicrohttpd/'
  url 'http://github.com/scottjg/libmicrohttpd.git', :sha => '0afa79261f'

  name 'libmicrohttpd'
  section 'libs'
  version '0.9.25+github2'
  description 'HTTP server library'

  conflicts 'libmicrohttpd5'
  replaces 'libmicrohttpd5'
  provides 'libmicrohttpd5', 'libmicrohttpd-dev', 'libmicrohttpd-dbg'
  build_depends 'libtool', 'autoconf', 'automake', 'texinfo'

  def build
  end

  def install
    system "autoreconf -fi"
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
