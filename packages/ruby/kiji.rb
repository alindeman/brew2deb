require 'mri'

class Kiji < MRI
  url 'https://github.com/twitter/rubyenterpriseedition187-248.git', :sha => '584cdea'
  homepage 'https://github.com/twitter/rubyenterpriseedition187-248/blob/master/README-kiji'

  name 'kiji'
  section 'interpreters'
  version '0.11.1+github1'
  description 'The Kiji Ruby virtual machine (installed in /opt)'

  conflicts 'ree'
  provides  'ree'
  replaces  'ree'

  build_depends \
    'google-perftools'

  depends \
    'google-perftools'

  def patches
    'patches/no-recursive-freeze.patch'
  end

  def build
    ENV['CFLAGS'] = '-O2 -ggdb -Wall -fPIC -fno-builtin-malloc
     -fno-builtin-calloc -fno-builtin-realloc -fno-builtin-free
     -fno-stack-protector'.gsub(/\s+/, ' ')
    ENV['LIBS'] = '-ltcmalloc_minimal'

    sh 'autoconf'
    configure :prefix => prefix, :disable_pthread => true, :disable_shared => true, :disable_ucontext => true, :enable_gc_debug => true
    make
  end

  def post_install
    super
  end

  private

  def prefix
    current_pathname_for('opt')
  end
end
