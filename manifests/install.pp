##
# The hazelcast::install class It commands the installation of the zip file
# 
class hazelcast::install inherits hazelcast {
  include ::archive

  File {
    owner => $::hazelcast::user,
    group => $::hazelcast::group,
  }

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
    ensure  => directory,
    recurse => true,
    owner   => $::hazelcast::user,
    group   => $::hazelcast::group,
  }
  -> archive { '/tmp/hazelcast.tar.gz':
    ensure       => present,
    source       => $::hazelcast::download_url,
    extract_path => $::hazelcast::root_dir,
    creates      => [$::hazelcast::install_dir, 'installed'].join('/'),
    user         => $::hazelcast::user,
    group        => $::hazelcast::group,
    extract      => true,
    cleanup      => false,
  }
# -> exec { "${::hazelcast::install_dir} change of owners":
#   command => "/bin/chown -R ${::hazelcast::user}.${::hazelcast::group} ${::hazelcast::install_dir}",
# }
  -> file { $::hazelcast::cli:
    ensure  => present,
    content => epp("${module_name}/hazelcast-cli.sh.epp"),
  }
}
