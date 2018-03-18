##
# = class: hazelcast::service - The class that handles the hazelcast service
#
class hazelcast::service inherits hazelcast {
  include ::systemd::systemctl::daemon_reload

  file { '/lib/systemd/system/hazelcast.service':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp("${module_name}/hazelcast.service.epp", { }),
  }
  ~> Class['systemd::systemctl::daemon-reload']

  service { $::hazelcast::service_name:
    ensure     => $::hazelcast::service_ensure,
    subscribe  => [
      File[[$hazelcast::config_dir, 'hazelcast.xml'].join('/)')],
      File[[$hazelcast::config_dir, 'hazelcast.conf'].join('/)')],
      File['/lib/systemd/system/hazelcast.service']
    ]
  }
}
