##
# = class: hazelcast::service - The class that handles the hazelcast service
#
class hazelcast::service {
  include ::systemd::systemctl::daemon_reload

  file { '/usr/lib/systemd/system/hazelcast.service':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => epp("${module_name}/hazelcast.service.epp", { }),
  }

  service { $::hazelcast::service_name:
    ensure     => $::hazelcast::service_ensure,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File['/usr/lib/systemd/system/hazelcast.service'],
  }
}
