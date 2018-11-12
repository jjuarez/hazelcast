##
# The hazelcast main class
#
# @summary This is the hazelcast main module class.
# 
# @example Declaring the class
#   include '::hazelcast'
#
# @param root_dir                    [Stdlib::Absolutepath]    The root directory of the hazelcast installation, by default /opt
# @param config_dir                  [Stdlib::Absolutepath]    The configuration directory where to store the config files
# @param version                     [String]                  The version of the hazelcast (we support the product from the 3.9.2 version)
# @param download_url                [Stdlib::Httpurl]         The download URL of the package
# @param manage_users                [Boolean]                 This allow us to create the group and user to manage the hazelcast process
# @param user                        [String]                  The user of the hazelcast process
# @param group                       [String]                  The group of the hazelcast process
# @param java                        [Stdlib::Absolutepath]    The JAVA_HOME environment variable
# @param java_options                [String]                  This is a "free" string to add your favourite JVM's options
# @param classpath                   [Array[String]]           The classpath to launch the JVM
# @param service_ensure              [Stdlib::Ensure::Service] The status desired for the service
# @param service_success_exit_status [Integer]                 The success exit code from the hazelcast process
# @param service_restart_timeout     [Integer]                 The time to wait doing a restart operation
# @param group_name                  [String]                  The user of the cluster
# @param group_password              [String]                  The password of the cluster user
# @param cluster_discovery           [Enum[tcp,multicast,aws]  The discovery mechanims to use in the cluster
# @param cluster_members             [Array[String]]           The list of the members which belong to the cluster
# @param cluster_discovery_aws       [Struct]                  The configuration to make possible the AWS service discovery
# @param install_client_addons       [Boolean]                 Switch to allow the installation of the client console
# @param time_to_live_seconds        [Integer]                 The TTL gobal behaviour
# @param custom_ttls                 [Array[Struct]]           The list of the custom items TTLs
# @param management_center_enabled   [Boolean]                 The switch to enable/disable the hazelcast management center configuration
# @param management_center_url       [Stdlib::Httpurl]         The URL to configure as the hazelcast management center endpoint
#
class hazelcast(
  Optional[Stdlib::Absolutepath]          $root_dir,
  Optional[Stdlib::Absolutepath]          $config_dir,
  Optional[String]                        $version,
  Optional[Stdlib::Httpurl]               $download_url,
  Optional[Boolean]                       $manage_user,
  Optional[String]                        $user,
  Optional[String]                        $group,
  Optional[Stdlib::Absolutepath]          $java,
  Optional[String]                        $java_options,
  Optional[Array[String]]                 $classpath,
  Optional[Stdlib::Ensure::Service]       $service_ensure,
  Optional[Integer]                       $service_success_exit_status,
  Optional[Integer]                       $service_restart_timeout,
  Optional[String]                        $group_name,
  Optional[String]                        $group_password,
  Optional[Enum[tcp,multicast,aws]]       $cluster_discovery,
  Optional[Array[String]]                 $cluster_members,
  Optional[Struct[{ access_key  => Optional[String],
                    secret_key  => Optional[String],
                    region      => Optional[String],
                    host_header => Optional[String],
                    sg_name     => Optional[String],
                    tag_key     => Optional[String],
                    tag_value   => Optional[String]
                  }]]                     $cluster_discovery_aws,
  Optional[Boolean]                       $install_client_addons,
  Optional[Integer]                       $time_to_live_seconds,
  Optional[Array[Struct[{ name            => String[1],
                          seconds         => Integer,
                          max_size_policy => String[1],
                          max_size_value  => Integer,
                          eviction_policy => Enum['LFU','LRU']
                        }]]]              $custom_ttls,
  Optional[Boolean]                       $management_center_enabled,
  Optional[Stdlib::Httpurl]               $management_center_url,
){

  $tar_file           = "hazelcast-${::hazelcast::version}.tar.gz"
  $tmp_file           = join(['/tmp', $::hazelcast::tar_file], '/')
  $install_dir        = join([$::hazelcast::root_dir, "hazelcast-${::hazelcast::version}"], '/')
  $link_dir           = join([$::hazelcast::root_dir, 'hazelcast'], '/')
  $server_jar_file    = join([$::hazelcast::install_dir, 'lib', "hazelcast-all-${::hazelcast::version}.jar"], '/')
  $cli                = join([$::hazelcast::install_dir, 'bin', 'hazelcast-cli.sh'], '/')
  $config_file        = join([$::hazelcast::config_dir, 'hazelcast.conf'], '/')
  $server_config_file = join([$::hazelcast::config_dir, 'hazelcast.xml'], '/')
  $client_config_file = join([$::hazelcast::config_dir, 'hazelcast-client.xml'], '/')
  $server_classpath   = join([$server_jar_file, $::hazelcast::classpath.flatten], ':')

  $init_style         = $facts['service_provider']

  if $::hazelcast::cluster_discovery == 'aws' {
    # Check for mandatory configuration items
    ['access_key', 'secret_key', 'tag_key', 'tag_value'].each |String $mp| {
      unless $::hazelcast::cluster_discovery_aws[$mp] {
        fail("The AWS discovery requires parameter: ${mp}")
      }
    }
  }

  contain '::hazelcast::install'
  contain '::hazelcast::config'
  contain '::hazelcast::service'

  Class['::hazelcast::install']
  -> Class['::hazelcast::config']
  ~> Class['::hazelcast::service']
}
