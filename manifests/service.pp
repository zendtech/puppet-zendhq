# @summary Manage zendhq service
#
# @api private
#
class zendhq::service {
  assert_private()
  $ensure = $zendhq::service_ensure
  $enable = $zendhq::service_enable
  $provider = $zendhq::service_provider
  $service_name = $zendhq::service_name

  $restart = $facts['service_provider'] ? {
    'systemd' => "systemctl restart ${service_name}",
    undef     => "service ${service_name} restart",
    default   => undef
  }

  service { $service_name:
    ensure     => $ensure,
    enable     => $enable,
    provider   => $provider,
    hasrestart => true,
    restart    => $restart,
    hasstatus  => true,
  }
}
