require 'formula'

class Megaraid_sas < DebianFormula
  url 'https://github.com/github/megaraid_sas.git', :sha => '4fb0dce821e0b1e179a9a2cf152676c442cd39f0'

  name 'megaraid-sas'
  version '5.34-rc1+github1'
  section 'main'
  description 'GitHub\'s custom brewed MegaRAID SAS driver. Tastes like strawberries.'

  def build
    system "make"
  end

  def install
    system "mkdir -p #{destdir}/lib/modules/2.6.32-5-amd64/updates/kernel/drivers/scsi/megaraid/"
    system "cp src/*.ko #{destdir}/lib/modules/2.6.32-5-amd64/updates/kernel/drivers/scsi/megaraid/"
  end

  def postinst
    "
      #!/bin/sh
      set -e
      
      update-initramfs -u -k 2.6.32-5-amd64
    ".ui
  end
end
