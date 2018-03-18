##
# = class: hazelcast::install - The class that commands the installation of the zip file
# 
class hazelcast::install inherits hazelcast {
  include '::archive'

  if $hazelcast::manage_user {
    group { $hazelcast::group:
      ensure => present,
    }
    ->user { $hazelcast::user:
      ensure => present,
      gid    => $hazelcast::group,
    }
  }

  file { $hazelcast::install_dir:
    ensure => directory,
  }
  -> archive { '/tmp/hazelcast.tar.gz':
    ensure       => present,
    extract      => true,
    extract_path => $hazelcast::install_dir,
    source       => $hazelcast::download_url,
    creates      => [$hazelcast::install_dir], "hazelcast-${hazelcast::version}",
    cleanup      => true,
  }
}
