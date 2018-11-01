##
# The hazelcast::service class It handles the hazelcast service
#
class hazelcast::service inherits hazelcast {

  case $::hazelcasts::init_style {
    'systemd' : {
      file { '/lib/systemd/system/hazelcast.service':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => epp("${module_name}/service/hazelcast.service.systemd.epp"),
      }
      -> service { 'hazelcast':
        ensure     => $::hazelcast::service_ensure,
        hasrestart => true,
        hasstatus  => true,
        subscribe  => File[$::hazelcast::config_file],
      }
    }

    default: { fail("This service provider: ${facts.service_provider} is not supported") }
  }
}
