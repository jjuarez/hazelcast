##
# The hazelcast::install class It commands the installation of the zip file
# 
class hazelcast::install inherits hazelcast {
  include ::archive

  $flag_file = join([$::hazelcast::install_dir, 'readme.html'], '/')

  File {
    owner => $::hazelcast::user,
    group => $::hazelcast::group,
    mode  => '0750',
  }

  if $::hazelcast::manage_user {
    ensure_resource('group', $::hazelcast::group, {
      ensure => present,
    })

    ensure_resource('user', $::hazelcast::user, {
      ensure  => present,
      gid     => $::hazelcast::group,
      require => Group[$::hazelcast::group],
    })
  }

  archive { $::hazelcast::tmp_file:
    ensure       => present,
    extract      => true,
    extract_path => $::hazelcast::root_dir,
    source       => $::hazelcast::download_url,
    creates      => $flag_file,
    cleanup      => true,
  }
  -> file { $::hazelcast::install_dir:
    ensure  => directory,
    owner   => $::hazelcast::user,
    group   => $::hazelcast::group,
    mode    => '0750',
    recurse => true,
  }
  -> file { $::hazelcast::link_dir:
    ensure => link,
    target => $::hazelcast::install_dir,
  }

  if $::hazelcast::install_client_addons {
    file { $::hazelcast::cli:
      ensure  => present,
      content => epp("${module_name}/addons/hazelcast-cli.sh.epp"),
      require => File[$::hazelcast::install_dir],
    }
  }
}
