##
# = class: hazelcast::install - The class that commands the installation of the zip file
# 
class hazelcast::install {
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

  file { $::hazelcast::install_dir:
    ensure => directory,
  }
  -> archive { '/tmp/hazelcast.zip':
    ensure       => present,
    extract      => true,
    extract_path => '/tmp',
    source       => $::hazelcast::download_url,
    creates      => $::hazelcast::install_dir,
    cleanup      => false,
  }
}
