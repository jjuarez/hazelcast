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

  archive { '/tmp/hazelcast.tar.gz':
    ensure       => present,
    extract      => true,
    source       => $::hazelcast::download_url,
    extract_path => $::hazelcast::root_dir,
    user         => $::halezcast::user,
    group        => $::hazelcast::group,
    creates      => $::hazelcast::install_dir,
    cleanup      => true,
  }
}
