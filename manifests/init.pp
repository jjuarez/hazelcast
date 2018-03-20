##
# The hazelcast main class
#
# @summary This is the hazelcast main module class.
# 
# @example Declaring the class
#   include '::hazelcast'
#
# @param root_dir          The root directory of the hazelcast installation, by default /opt
# @param config_dir        The configuration directory where to store the config files
# @param version           The version of the hazelcast (we support the product from the 3.9.2 version)
# @param download_url      The download URL of the package
# @param manage_users      This switch allow us to create the group and user to manage the hazelcast process
# @param user              The user of the hazelcast process
# @param group             The group of the hazelcast process
# @param java_home         The JAVA_HOME directory where to find java executable
# @param java              The java executable file
# @param java_options      This is a "free" string to add your favourite JVM's options
# @param class_path        The classpath to launch the JVM
# @param service_ensure    The status desired for the service
# @param cluster_discovery The discovery mechanims to use in the cluster
# @param cluster_user      The user of the cluster
# @param cluster_password  The password of the cluster user
# @param cluster_members   The list of the members which belong to the cluster 
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
  Optional[Array[String]]           $class_path,
  Optional[Stdlib::Ensure::Service] $service_ensure,
  Optional[Enum['tcp']]             $cluster_discovery,
  Optional[String]                  $cluster_user,
  Optional[String]                  $cluster_password,
  Optional[Array]                   $cluster_members,
){

  $install_dir        = [$::hazelcast::root_dir, "hazelcast-${::hazelcast::version}"].join('/')
  $config_file        = [$::hazelcast::config_dir, 'hazelcast.conf'].join('/')
  $xml_config_file    = [$::hazelcast::config_dir, 'hazelcast.xml'].join('/')
  $all_jar_file       = [$::hazelcast::install_dir, 'lib', "hazelcast-all-${::hazelcast::version}.jar"].join('/')
  $complete_classpath = $::all_jar_file

  if $::hazelcast::class_path.size > 0 {
    $complete_class_path = "${complete_class_path}:${::hazelcast::class_path.join(':')}"
  }

  contain hazelcast::install
  contain hazelcast::config
  contain hazelcast::service

  Class['::hazelcast::install']
  -> Class['::hazelcast::config']
  ~> Class['::hazelcast::service']
}
