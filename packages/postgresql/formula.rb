class Postgresql < DebianFormula
  url 'http://ftp.postgresql.org/pub/source/v9.1.5/postgresql-9.1.5.tar.bz2'
  md5 'a8035688dba988b782725ac1aec60186'
  homepage 'http://www.postgresql.org/'

  section 'interpreters'
  name 'postgresql-9.1'
  version '9.1.5+github1'
  description 'Elephant DB'

  build_depends \
    'libreadline5-dev',
    'zlib1g-dev'

  depends \
    'libreadline5',
    'openssl'

  def options
    [
      ['--no-python', 'Build without Python support.'],
      ['--no-perl', 'Build without Perl support.'],
    ]
  end
  skip_clean :all

  def install
    make :install, 'DESTDIR' => destdir

    args = ["--disable-debug",
      "--prefix=#{prefix}",
      "--enable-thread-safety",
      "--with-gssapi",
      "--with-krb5",
      "--with-openssl",
      "--with-libxml", "--with-libxslt"]

    args << "--with-python" unless ARGV.include? '--no-python'
    args << "--with-perl" unless ARGV.include? '--no-perl'

    args << "--datadir=#{share}/#{name}"
    args << "--docdir=#{doc}"

    system "./configure", *args
    system "make install-world"
  end
end
