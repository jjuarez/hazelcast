##
# The hazelcast::service class It handles the hazelcast service
#
class hazelcast::service inherits hazelcast {

  if $::hazelcast::init_style == 'systemd' {
    file { '/etc/systemd/system/hazelcast-server.service':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => epp("${module_name}/service/hazelcast.service.systemd.epp"),
    }
    -> service { 'hazelcast-server':
      ensure     => $::hazelcast::service_ensure,
      hasrestart => true,
      hasstatus  => true,
      subscribe  => File[$::hazelcast::config_file],
    }
  }
  else {
    fail('This service provider is not supported')
  }
}
