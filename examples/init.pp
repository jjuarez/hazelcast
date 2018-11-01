#
# A very simple example of use
#
node default {

  class { '::hazelcast':
    version            => '3.9.4',
    download_url       => 'https://download.hazelcast.com/download.jsp?version=3.9.4&type=tar',
    manage_user        => true,
    user               => 'hz',
    group              => 'hz',
    cluster_discoverty => 'tcp',
    cluster_members    => [
      '172.16.24.24',
      '172.16.24.25'
    ],
  }
}
