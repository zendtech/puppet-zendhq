# @summary Manage ZendHQ package, service, and configuration
#
# @see https://help.zend.com/zendphp/current/content/zendhq/zendhq_service_configuration.htm for possible settings
#
# @example Basic ZendHQ setup
#   class { 'zendhq':
#     license_source => 'puppet:///modules/<MODULE_NAME>/zend/license'
#   }
#
# @example Setup ZendHQ with some configuration
#   class { 'zendhq':
#     license_source => 'puppet:///modules/<MODULE_NAME>/zend/license',
#     settings       => {
#       'zendhq.daemon_uri' => 'tcp://0.0.0.0:10090',
#     },
#   }
#
# @param license_source
#   Source path or puppet URL to license file
#
# @param settings
#   Hash of settings and their values
#
# @param service_provider
#   System service provider, like systemctl; auto-detected if left undef
#
# @param service_ensure
#   Enure value for the ZendHQ service
#
# @param service_name
#   Name of ZendHQ service
#
# @param service_enable
#   Whether the service should be enabled or not
#
# @param package_ensure
#   Ensure value for the ZendHQ package
#
# @param package_name
#   Name of the ZendHQ package
#
class zendhq (
  String[1] $license_source,
  Optional[Hash[String, Variant[String, Integer]]] $settings = undef,
  Optional[String[1]] $service_provider                      = undef,
  Enum['running', 'stopped'] $service_ensure                 = 'running',
  String[1] $service_name                                    = 'zendhqd',
  Boolean $service_enable                                    = true,
  String[1] $package_ensure                                  = 'installed',
  String[1] $package_name                                    = 'zendhqd',
) {
  if $facts['os']['name'] == 'CentOS' {
    package { 'epel-release': }
  }

  include zendhq::package
  include zendhq::service

  if $settings != undef {
    class { 'zendhq::config':
      notify    => Class['zendhq::service'],
      subscribe => Class['zendhq::package'],
    }
  }

  class { 'zend_common::license':
    source    => $license_source,
    notify    => Class['zendhq::service'],
    subscribe => Class['zendhq::package'],
  }
}
