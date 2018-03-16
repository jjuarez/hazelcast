##
# = class: hazelcast::install - The class that commands the installation of the zip file
# 
class hazelcast::install {
  include '::archive'

  archive { '/tmp/hazelcast.zip':
    ensure       => present,
    extract      => true,
    extract_path => '/tmp',
    source       => $::hazelcast::download_url,
    creates      => $::hazelcast::install_dir,
    cleanup      => false,
  }
}
