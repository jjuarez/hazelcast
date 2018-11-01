# hazelcast

[![Puppet Forge](http://img.shields.io/puppetforge/v/jjuarez/hazelcast.svg)](https://forge.puppetlabs.com/jjuarez/hazelcast)
[![Build Status](https://travis-ci.org/jjuarez/puppet-hazelcast.svg?branch=master)](https://travis-ci.org/jjuarez/puppet-hazelcast)


#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with hazelcast](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with hazelcast](#beginning-with-hazelcast)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

The aim of this module is quite simple, to help you with the instalation and setup of an hazelcast cluster

## Setup

A minimal setup using the default parameter values would be something like this:

```puppet
class { '::hazelcast': }
```

or better using the import clause in this form:

```puppet
import '::hazelcast'
```

### Setup Requirements

Here you can see a more complex setup

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
  java_home         => '/usr/lib/jvm/jre1.8.0',
  java_options      => '-Dfoo=bar',
  classpath         => [
    'foo.jar',
    'bar.jar'
  ],
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



Of course we recommend you to configure the module using hiera, this is more reliable and flexible depending of your hierarchy, you can view the previous example here:

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
hazelcast::java_home: '/usr/lib/jvm/jre1.8.0'
hazelcast::java_options: '-Dfoo=bar'
hazelcast::classpath:
  - foo.jar
  - bar.jar
hazelcast::group_name: 'hzuser'
hazelcast::group_password: 'supersecret'
hazelcast::cluster_discovery: 'tcp'
hazelcast::cluster_members:
  - '192.168.0.23'
  - '192.168.0.24'
  - '192.168.0.25'
```

Another example of configuration but this one more focused on the custom TTL configuration would be like this one:

```puppet
class { '::hazelcast':
  version           => '3.9.4',
  download_url      => 'http://download.hazelcast.com/download.jsp?version=3.9.4&type=tar&p=',
  java_home         => '/usr/lib/jvm/jre1.8.0',
  group_name        => 'hzuser',
  group_password    => 'supersecret',
  cluster_discovery => 'tcp',
  cluster_members   => [
    '192.168.0.23',
    '192.168.0.24',
    '192.168.0.25'
  ],
  time_to_live =>10,
  custom_ttls  =>[
    {
      name            => 'my_hash',
      seconds         => 10,
      max_size_policy => 10,
      max_size_value  => 15
      eviction_policy => LRU
   }
  ],
}

```
you can add as many TTL configuration as you need, and of course is also possible to set this configuration in hiera:

```yaml
---
hazelcast::version: '3.9.4'
hazelcast::download_url: 'http://download.hazelcast.com/download.jsp?version=3.9.4&type=tar&p='
hazelcast::java_home: '/usr/lib/jvm/jre1.8.0'
hazelcast::group_name: 'hzuser'
hazelcast::group_password: 'supersecret'
hazelcast::cluster_discovery: 'tcp'
hazelcast::cluster_members:
  - '192.168.0.23'
  - '192.168.0.24'
  - '192.168.0.25'
hazelcast::time_to_live_seconds: 10
hazelcast::custom_ttls:
  - 
    name: my_map
    seconds: 10
    max_size_policy: 10
    max_size_value: 15
    eviction_policy: LRU
```

### Beginning with hazelcast

You can take a look to the awesome documentation of the Hazelcast project [here](https://hazelcast.org/documentation/)

## Usage

Use the module is extremely easy, just add it to your Puppetfile, import the class in your profile class and configure it with hiera.
The module deploy a small CLI util to check the status of the cluster, this is deployed among the hazelcast package, for example, (with root_dir=/opt and version=3.9.3) it will be deployed in:

```
/opt/hazelcast-3.9.3/bin/hazelcast-cli.sh
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

until now, but we've plans to support other distributions like Ubuntu ASAP.

Cluster discovery mechanims supported:

* TCP

The only discovery mechanims supported is TCP in the current version (0.2.6 at the time to write this), but we've plans to develop the AWS discovery

## Development

Please feel free to send me your ideas in the form of pull requests, and fill an issue if you discover one

