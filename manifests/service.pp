##
# = class: hazelcast::service - The class that handles the hazelcast service
#
class hazelcast::service {
  include ::systemd::systemctl::daemon_reload

  $systemd_unit_file = '/lib/systemd/system/hazelcast.service'

  file { $systemd_unit_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp("${module_name}/hazelcast.service.epp", { }),
  }

  service { $::hazelcast::service_name:
    ensure     => $::hazelcast::service_ensure,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File[$systemd_unit_file],
  }
}
