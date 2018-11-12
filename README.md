# hazelcast

[![Puppet Forge](http://img.shields.io/puppetforge/v/jjuarez/hazelcast.svg)](https://forge.puppetlabs.com/jjuarez/hazelcast)
[![Build Status](https://travis-ci.org/jjuarez/puppet-hazelcast.svg?branch=master)](https://travis-ci.org/jjuarez/puppet-hazelcast)


#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with hazelcast](#setup)
    * [Setup examples](#setup-examples)
    * [Beginning with hazelcast](#beginning-with-hazelcast)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

The aim of this module is quite simple, to help you with the instalation and setup of a hazelcast server or cluster

## Setup

A minimal setup using the default parameter values would be something like this:

```puppet
class { '::hazelcast': }
```

or better using the include clause in this form:

```puppet
include '::hazelcast'
```

### Setup examples

Be aware about the exit code that hazelcast use, it's not 0, it's 143, so after a service stop the systemd stayed as failed,
anyway after the 0.6.1 version ofthe module this allows you to configure this detail in the systemd unit, and also the time to
wait during a restart operation.

Example of these custom configurations

```yaml
hazelcast::config_dir: '/etc/hazelcast'
hazelcast::version: '3.9.4'
hazelcast::service_ensure: 'running'
hazelcast::service_successful_exit_status: 143 # This is the default value
hazelcast::service_restart_timeout: 30 # This is the default value, 30 seconds
hazelcast::manage_user: true
hazelcast::user: 'hazelcast'
hazelcast::group: 'hazelcast'
hazelcast::download_url: 'http://download.hazelcast.com/download.jsp?version=3.9.4&type=tar&p='
hazelcast::java: '/usr/lib/jvm/jre1.8.0'
hazelcast::java_options: '-Xss256k -Xms64m -Xmx128m -XX:+UseG1GC -Dsome.awesome.superkey=value'
hazelcast::group_name: 'hzuser'
hazelcast::group_password: 'supersecret'
hazelcast::cluster_discovery: 'multicast'
```

#### Cluster discovery
##### TCP

Here you can see a more complex setup for a cluster of three members doing the discovery by TCP

```puppet
class { '::hazelcast':
  root_dir          => '/opt',
  config_dir        => '/etc/hazelcast',
  version           => '3.9.4',
  service_ensure    => 'running',
  manage_user       => true,
  user              => 'hazelcast',
  group             => 'hazelcast',
  download_url      => 'http://download.hazelcast.com/download.jsp?version=3.9.4&type=tar&p=',
  java              => '/usr/lib/jvm/jre1.8.0/bin/java',
  java_options      => '-Xss256k -Xms64m -Xmx128m -XX:+UseG1GC -Dsome.awesome.superkey=value',
  group_name        => 'hzuser',
  group_password    => 'supersecret',
  cluster_discovery => 'tcp',
  cluster_members   => [
    '192.168.0.23',
    '192.168.0.24',
    '192.168.0.25'
  ],
}
```

Of course we recommend you to configure the module always using hiera, this is more reliable and flexible depending of your hierarchy, you can view the previous example here:

```yaml
---
hazelcast::root_dir: '/opt'
hazelcast::config_dir: '/etc/hazelcast'
hazelcast::version: '3.9.4'
hazelcast::service_ensure: 'running'
hazelcast::manage_user: true
hazelcast::user: 'hazelcast'
hazelcast::group: 'hazelcast'
hazelcast::download_url: 'http://download.hazelcast.com/download.jsp?version=3.9.4&type=tar&p='
hazelcast::java: '/usr/lib/jvm/jre1.8.0'
hazelcast::java_options: '-Xss256k -Xms64m -Xmx128m -XX:+UseG1GC -Dsome.awesome.superkey=value'
hazelcast::group_name: 'hzuser'
hazelcast::group_password: 'supersecret'
hazelcast::cluster_discovery: 'tcp'
hazelcast::cluster_members:
  - '192.168.0.23'
  - '192.168.0.24'
  - '192.168.0.25'
```

##### Multicast

```yaml
---
hazelcast::root_dir: '/opt'
hazelcast::config_dir: '/etc/hazelcast'
hazelcast::version: '3.9.4'
hazelcast::service_ensure: 'running'
hazelcast::manage_user: true
hazelcast::user: 'hazelcast'
hazelcast::group: 'hazelcast'
hazelcast::download_url: 'http://download.hazelcast.com/download.jsp?version=3.9.4&type=tar&p='
hazelcast::java: '/usr/lib/jvm/jre1.8.0'
hazelcast::java_options: '-Dfoo=bar'
hazelcast::group_name: 'hzuser'
hazelcast::group_password: 'supersecret'
hazelcast::cluster_discovery: 'multicast'
```

##### AWS

To a complete description of the method of discovery I encorage you to take a look to the Hazelcast documentation, which is available
[here](https://docs.hazelcast.org/docs/3.9/manual/html-single/index.html#aws-cloud-discovery) these are the parameters:

|Parameter|Description|Required|default|
|---------|-----------|:------:|:-----:|
|access_key|The AWS access key id|yes| |
|secret_key|The AWS secret Key|yes| |
|region|The AWS region|no| us-west-1 |
|host_header|The Amazon host header domain|no| amazonaws.com |
|sg_name|The identificator of a security group which allow access to the cluster instances|no|-|
|tag_key|The key of the tag to filter the ec2 instances|yes|-|
|tag_value|The value of the tag key to filter the ec2 instances|yes|-|



```yaml
---
hazelcast::root_dir: '/opt'
hazelcast::config_dir: '/etc/hazelcast'
hazelcast::version: '3.9.4'
hazelcast::service_ensure: 'running'
hazelcast::manage_user: true
hazelcast::user: 'hazelcast'
hazelcast::group: 'hazelcast'
hazelcast::download_url: 'http://download.hazelcast.com/download.jsp?version=3.9.4&type=tar&p='
hazelcast::java: '/usr/lib/jvm/jre1.8.0'
hazelcast::java_options: '-Dfoo=bar'
hazelcast::group_name: 'hzuser'
hazelcast::group_password: 'supersecret'
hazelcast::cluster_discovery: 'aws'
hazelcast::cluster_discovery_aws:
  access_key: XXXX
  secret_key: XXXX
  region: eu-west-1
  host_header: amazonaws.com
  security_group_name: sg-XXXXX
  tag_key: hz_cluster
  tag_value: development
```

#### Custom TTLs
Another example of configuration but this one focused on the custom TTL configuration would be like this one, and remember you can add as many TTL configuratio as you need

```yaml
---
hazelcast::version: '3.9.4'
hazelcast::download_url: 'http://download.hazelcast.com/download.jsp?version=3.9.4&type=tar&p='
hazelcast::java: '/usr/lib/jvm/jre1.8.0'
hazelcast::group_name: 'hzuser'
hazelcast::group_password: 'supersecret'
hazelcast::cluster_discovery: 'multicast'
hazelcast::time_to_live_seconds: 10
hazelcast::custom_ttls:
  - 
    name: my_map
    seconds: 10
    max_size_policy: 10
    max_size_value: 15
    eviction_policy: LRU
   - name: another_map
     seconds: 35
     max_size_policy: 250
     max_size_value: 15
     eviction_policy: LFU
```

### Beginning with hazelcast

You have to take a look to the awesome documentation of the Hazelcast project [here](https://hazelcast.org/documentation/)

## Usage

I think to use the module have to be pretty easy, just add it to your Puppetfile, import the class in your profile class and configure it with hiera.
The module deploy a small CLI util to check the status of the cluster, this is deployed among the hazelcast package, for example, (with root_dir=/opt and version=3.9.4) it will be deployed in:

```
/opt/hazelcast/bin/hazelcast-cli.sh
```

with the appropriate configuration file to fit the cluster deployed, this file is located in (with config_dir=/etc/hazelcast)

```
/etc/hazelcast/hazelcast-client.xml
```

## Reference

You can take a look to the awesome documentation of the Hazelcast project [here](https://hazelcast.org/documentation/)


## Limitations

The module supports only **OS distributions** based on systemd, as you might know:

* Debian Stretch
* Debian Jessie
* Red-Hat
* CentOS 7
* Ubuntu: 16.04, 18.04, 18.10
* Archlinux

## Cluster discovery mechanims supported:

* TCP
* Multicast
* AWS: EC2 tags and Security group

## Development

Please feel free to send me your ideas in the form of pull requests, and fill me an issue if you discover one

