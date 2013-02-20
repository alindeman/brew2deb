class LameGitHub < DebianFormula
  homepage 'http://lame.sourceforge.net/'
  url 'http://downloads.sourceforge.net/sourceforge/lame/lame-3.99.5.tar.gz'
  sha1 '03a0bfa85713adcc6b3383c12e2cc68a9cfbf4c4'
  version "3.99.5-github2"
  description "mp3 codecs for github.fm"
  name "lame-github"

  def build
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--enable-nasm"
  end

  def install
    system "make install"
  end
end
