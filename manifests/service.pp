##
# = class: hazelcast::service - The class that handles the hazelcast service
#
class hazelcast::service inherits hazelcast {

  ::system::unit_file { 'hazelcast.service'
    content => epp("${module_name}/hazelcast.service.epp", { }),
  }
  ~> service { $::hazelcast::service_name:
    ensure     => $::hazelcast::service_ensure,
    subscribe  => File['/lib/systemd/system/hazelcast.service'],
  }
}
