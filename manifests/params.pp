# @summary default settings and according to operating system
#
# @api private
#
class zendhq::params {
  $service_ensure = running
  $service_enable = true
  $service_name = 'zendhqd'
  $package_ensure = present
  $package_name = 'zendhqd'
}
