# @summary Manage the zendhqd package
#
# @api private
#
class zendhq::package {
  assert_private()

  $package_name = $zendhq::package_name
  $package_ensure = $zendhq::package_ensure

  class { 'zend_common::repo':
    product      => 'ZendHQ',
    support_urls => {
      supported_platforms => 'https://help.zend.com/zendphp/current/content/installation/zendhq_supported_platforms.htm',
    },
  }

  if $facts['os']['family'] == 'Debian' {
    Class['apt::update'] -> Package[$package_name]
  }

  package { $package_name:
    ensure => $package_ensure,
  }
}
