#
# hazelcast
#
class hazelcast(
  Optional[Stdlib::Absolutepath] $install_dir,
  Optional[Stdlib::Absolutepath] $config_dir,
  Optional[String]               $version,
  Optional[String]               $service_name,
  Optional[Boolean]              $manage_user,
  Optional[String]               $user,
  Optional[String]               $group,
  Optional[String]               $java,
  Optional[String]               $java_options,
  Optional[String]               $hazelcast_options
){

  contain hazelcast::install
  contain hazelcast::config
  contain hazelcast::service

  Class['::hazelcast::install']
  -> Class['::hazelcast::config']
  ~> Class['::hazelcast::service']
}
