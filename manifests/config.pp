##
# = class: hazelcast::config - Handles the configuration for the hazelcast process
#
class hazelcast::config inherits hazelcast {

  File {
    owner => $::halezcast::user,
    group => $::halezcast::group,
    mode  => '0640',
  }

  file { $::hazelcast::config_dir:
    ensure => directory,
  }
  -> file { $::hazelcast::config_file:
    ensure  => present,
    content => epp("${module_name}/hazelcast.conf.epp"),
  }
  -> file { $::hazelcast::xml_config_file:
    ensure  => present,
    content => epp("${module_name}/hazelcast.xml.epp"),
  }
}
