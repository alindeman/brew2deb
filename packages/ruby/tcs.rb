require 'yarv'

class TCS < YARV
  url 'git://github.com/github/ruby-thecodeshop', :sha => '61967b176e5cc31689045457503e3f887cef6ca4'
  homepage 'https://github.com/thecodeshop/ruby/wiki'

  name 'rbenv-1.9.3-p231-tcs-github'
  section 'interpreters'
  version '1.0.7+1'
  description 'The YARV Ruby virtual machine + TCS patches + GitHub patches'

  build_depends \
    'google-perftools (>= 1.8), google-perftools (<= 1.9)',
    'jemalloc'

  depends \
    'google-perftools (>= 1.8), google-perftools (<= 1.9)',
    'jemalloc'

  def build
    sh 'autoconf'
    inreplace 'version.h', /GitHub v.+"/, "GitHub v#{self.class.version}\""
    cp 'version.h', 'version.h.pristine'
    super
  end

  def install
    cp 'version.h.pristine', 'version.h'
    make 'ruby'
    touch 'version.h'
    super
    bin.install_p 'ruby', 'ruby-libcmalloc'
    (include/'ruby-1.9.1').install Dir['*.{h,inc}']

    # wait to touch version.h last modified timestamp (1 sec resolution),
    # so make recognizes the change and rebuilds
    sleep 1

    cp 'version.h.pristine', 'version.h'
    inreplace 'version.h', '"-tcs-github"', '"-tcs-github-tcmalloc"'
    make 'ruby-tcmalloc', 'RUBY_INSTALL_NAME=ruby-tcmalloc', 'MAINLIBS=-ltcmalloc'
    bin.install 'ruby-tcmalloc'
    bin.install_p 'ruby-tcmalloc', 'ruby'

    sleep 1

    cp 'version.h.pristine', 'version.h'
    inreplace 'version.h', '"-tcs-github"', '"-tcs-github-jemalloc"'
    make 'ruby-jemalloc', 'RUBY_INSTALL_NAME=ruby-jemalloc', 'MAINLIBS=-ljemalloc'
    bin.install 'ruby-jemalloc'
  end
end
