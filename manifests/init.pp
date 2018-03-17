#
# hazelcast
#
class hazelcast(
  Optional[Stdlib::Absolutepath]    $install_dir,
  Optional[Stdlib::Absolutepath]    $config_dir,
  Optional[String]                  $version,
  Optional[Stdlib::Httpurl]         $download_url,
  Optional[String]                  $service_name,
  Optional[Boolean]                 $manage_user,
  Optional[String]                  $user,
  Optional[String]                  $group,
  Optional[String]                  $java,
  Optional[String]                  $java_options,
  Optional[Stdlib::Ensure::Service] $service_ensure,
){

  File {
    owner => $hazelcast::user,
    group => $hazelcast::group,
  }

  contain hazelcast::install
  contain hazelcast::config
  contain hazelcast::service

  Class['::hazelcast::install']
  -> Class['::hazelcast::config']
  ~> Class['::hazelcast::service']
}
