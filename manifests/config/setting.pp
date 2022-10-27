# @summary Configure a zendhqd.ini setting
#
# @see https://help.zend.com/zendphp/current/content/zendhq/zendhq_service_configuration.htm for possible keys and values
#
# @api private
#
# @example
#   zendhq::config::setting { 'zendhq.daemon_uri':
#     value: 'tcp://0.0.0.0:10090',
#   }
#
# @param value
#   What to set the setting's value to
#
define zendhq::config::setting (
  Optional[Variant[Integer, String]] $value = undef,
) {
  assert_private()

  $_ensure = $value ? {
    undef   => 'absent',
    default => 'present',
  }

  ini_setting { $title:
    ensure  => $_ensure,
    value   => $value,
    path    => '/opt/zend/zendphp/etc/zendhqd.ini',
    setting => $title,
  }
}
