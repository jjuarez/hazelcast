##
# The hazelcast::config class It handles the configuration for the hazelcast process
#
class hazelcast::config inherits hazelcast {

  File {
    owner => $::hazelcast::user,
    group => $::hazelcast::group,
    mode  => '0640',
  }

  file { $::hazelcast::config_dir:
    ensure => directory,
  }
  -> file { $::hazelcast::server_config_file:
    ensure  => present,
    content => epp("${module_name}/config/hazelcast.xml.epp"),
  }

  if $::hazelcast::install_client_addons {
    file { $::hazelcast::client_config_file:
      ensure  => present,
      content => epp("${module_name}/config/hazelcast-client.xml.epp"),
      require => File[$::hazelcast::config_dir],
    }
  }
}
