class GeoIPCityDB < DebianFormula
  VERSION = "GeoIP-133_20120228"

  homepage 'http://www.maxmind.com/app/city'
  url "#{VERSION}.tar.gz"
  md5 'aa55d9326bd13d81ae32ef361bdd2926'

  name 'geoip-city'
  version VERSION.sub('GeoIP-','').gsub('_','.') + '+github1'
  description 'City Database for use with the GeoIP library'

  depends 'libgeoip-dev', 'libgeoip1'

  def build
  end

  def install
    (share/'GeoIP').mkpath
    (share/'GeoIP').install "../#{VERSION}"
    (share/'GeoIP/GeoIPCity.dat').make_relative_symlink(share/"GeoIP/#{VERSION}/GeoIPCity.dat")
  end
end
