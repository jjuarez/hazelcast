##
# The hazelcast main class
#
# @summary This is the hazelcast main module class.
# 
# @example Declaring the class
#   include '::hazelcast'
#
# @param root_dir                  The root directory of the hazelcast installation, by default /opt
# @param config_dir                The configuration directory where to store the config files
# @param version                   The version of the hazelcast (we support the product from the 3.9.2 version)
# @param download_url              The download URL of the package
# @param manage_users              This switch allow us to create the group and user to manage the hazelcast process
# @param user                      The user of the hazelcast process
# @param group                     The group of the hazelcast process
# @param java                      This parameter should point to the java executable
# @param java_options              This is a "free" string to add your favourite JVM's options
# @param classpath                 The classpath to launch the JVM
# @param service_ensure            The status desired for the service
# @param group_name                The user of the cluster
# @param group_password            The password of the cluster user
# @param cluster_discovery         The discovery mechanims to use in the cluster
# @param cluster_members           The list of the members which belong to the cluster
# @param time_to_live_seconds      The TTL general bihaviour
# @param custom_ttls               The list of the custom items TTLs
# @param management_center_enabled The switch to enable/disable the hazelcast management center configuration
# @param management_center_url     The URL to configure as the hazelcast management center endpoint
#
class hazelcast(
  Optional[Stdlib::Absolutepath]    $root_dir,
  Optional[Stdlib::Absolutepath]    $config_dir,
  Optional[String]                  $version,
  Optional[Stdlib::Httpurl]         $download_url,
  Optional[Boolean]                 $manage_user,
  Optional[String]                  $user,
  Optional[String]                  $group,
  Optional[Stdlib::Absolutepath]    $java,
  Optional[String]                  $java_options,
  Optional[Array[String]]           $classpath,
  Optional[Stdlib::Ensure::Service] $service_ensure,
  Optional[String]                  $group_name,
  Optional[String]                  $group_password,
  Optional[Enum['tcp']]             $cluster_discovery,
  Optional[Array]                   $cluster_members,
  Optional[Integer]                 $time_to_live_seconds,
  Optional[Array[Struct[{ name            => String[1],
                          seconds         => Integer,
                          max_size_policy => String[1],
                          max_size_value  => Integer,
                          eviction_policy => Enum['LFU', 'LRU']
                        }]]]        $custom_ttls,
  Optional[Boolean]                 $management_center_enabled,
  Optional[Stdlib::Httpurl]         $management_center_url,
){

  $tar_file           = "hazelcast-${::hazelcast::version}.tar.gz"
  $tmp_file           = join(['/tmp', $::hazelcast::tar_file], '/')
  $install_dir        = join([$::hazelcast::root_dir, "hazelcast-${::hazelcast::version}"], '/')
  $link_dir           = join([$::hazelcast::root_dir, 'hazelcast'], '/')
  $all_jar_file       = join([$::hazelcast::install_dir, 'lib', "hazelcast-all-${::hazelcast::version}.jar"], '/')
  $cli                = join([$::hazelcast::install_dir, 'bin', 'hazelcast-cli.sh'], '/')
  $config_file        = join([$::hazelcast::config_dir, 'hazelcast.conf'], '/')
  $server_config_file = join([$::hazelcast::config_dir, 'hazelcast.xml'], '/')
  $client_config_file = join([$::hazelcast::config_dir, 'hazelcast-client.xml'], '/')
  $complete_classpath = join([$all_jar_file, $::hazelcast::classpath.flatten], ':')

  contain '::hazelcast::install'
  contain '::hazelcast::config'
  contain '::hazelcast::service'

  Class['::hazelcast::install']
  -> Class['::hazelcast::config']
  ~> Class['::hazelcast::service']
}
