# @summary Configure zendhq.ini settings
#
# @api private
#
# @example
#   class { 'zendhq::config':
#     notify    => Class['zendhq::service'],
#     subscribe => Class['zendhq::package'],
#   }
#
class zendhq::config {
  assert_private()
  $settings = $zendhq::settings

  $real_settings = Hash($settings.map |$setting_key, $setting_value| {
      [$setting_key, { value => $setting_value }]
  })

  create_resources(::zendhq::config::setting, $real_settings)
}
