#
# hazelcast
#
class hazelcast(
  Optional[Stdlib::Absolutepath]    $root_dir,
  Optional[Stdlib::Absolutepath]    $config_dir,
  Optional[String]                  $version,
  Optional[Stdlib::Httpurl]         $download_url,
  Optional[Boolean]                 $manage_user,
  Optional[String]                  $user,
  Optional[String]                  $group,
  Optional[Stdlib::Absolutepath]    $java_home,
  Optional[Stdlib::Absolutepath]    $java,
  Optional[String]                  $java_options,
  Optional[Stdlib::Ensure::Service] $service_ensure,
  Optional[Enum['tcp']]             $cluster_discovery,
  Optional[String]                  $cluster_user,
  Optional[String]                  $cluster_password,
  Optional[Array]                   $cluster_members,
){

  $install_dir     = [$::hazelcast::root_dir, "hazelcast-${::hazelcast::version}"].join('/')
  $config_file     = [$::hazelcast::config_dir, 'hazelcast.conf'].join('/')
  $xml_config_file = [$::hazelcast::config_dir, 'hazelcast.xml'].join('/')

  contain hazelcast::install
  contain hazelcast::config
  contain hazelcast::service

  Class['::hazelcast::install']
  -> Class['::hazelcast::config']
  ~> Class['::hazelcast::service']
}
