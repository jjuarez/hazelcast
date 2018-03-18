##
# = class: hazelcast::install - The class that commands the installation of the zip file
# 
class hazelcast::install inherits hazelcast {
  include '::archive'

  if $::hazelcast::manage_user {
    group { $::hazelcast::group:
      ensure => present,
    }
    ->user { $::hazelcast::user:
      ensure => present,
      gid    => $::hazelcast::group,
    }
  }

# file { $::hazelcast::install_dir:
#   ensure => directory,
#   owner  => $::hazelcast::user,
#   group  => $::hazelcast::group,
# }
# ->
   archive { '/tmp/hazelcast.tar.gz':
    ensure       => present,
    extract      => true,
    source       => $::hazelcast::download_url,
    extract_path => $::hazelcast::install_dir,
    creates      => $::hazelcast::install_dir,
    user         => $::halezcast::user,
    group        => $::hazelcast::group,
    cleanup      => true,
  }
}
