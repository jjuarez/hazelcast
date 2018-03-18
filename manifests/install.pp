##
# = class: hazelcast::install - The class that commands the installation of the zip file
# 
class hazelcast::install inherits hazelcast {
  include '::archive'

  if $::hazelcast::manage_user {
    ensure_resource('group', $::hazelcast::group, {
      ensure => present,
    })
    ensure_resource('user', $::hazelcast::user, {
      ensure => present,
      gid    => $::hazelcast::group,
    })
  }

  file { $::hazelcast::install_dir:
    ensure => directory,
    owner  => $::hazelcast::user,
    group  => $::hazelcast::group,
  }
  -> archive { '/tmp/hazelcast.tar.gz':
    ensure       => present,
    source       => $::hazelcast::download_url,
    extract_path => $::hazelcast::root_dir,
    creates      => [$::hazelcast::install_dir, 'installed'].join('/'),
    user         => $::halezcast::user,
    group        => $::hazelcast::group,
    extract      => true,
    cleanup      => false,
  }
}
