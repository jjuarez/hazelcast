##
# The hazelcast::service class It handles the hazelcast service
#
class hazelcast::service inherits hazelcast {

  service { 'hazelcast':
    ensure     => $::hazelcast::service_ensure,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File[$::hazelcast::config_file],
  }
  -> file { '/lib/systemd/system/hazelcast.service':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp("${module_name}/hazelcast.service.epp"),
  }
}
