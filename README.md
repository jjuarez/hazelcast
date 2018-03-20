
# hazelcast

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

The aim of this module is to help you with the instalation and setup of the hazelcast cluster

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
  version           => '3.9.3',
  root_dir          => '/opt',
  config_dir        => '/etc/hazelcast',
  service_ensure    => 'running',
  manage_user       => true,
  user              => 'hazelcast',
  group             => 'hazelcast',
  download_url      => 'http://download.hazelcast.com/download.jsp?verson=3.9.3&type=tar&p=28888',
  java_home         => '/usr/lib/jvm/jre1.8.0',
  java_options      => '-Dfoo=bar',
  classpath         => [
    'foo.jar',
    'bar.jar'
  ],
  cluster_discovery => 'tcp',
  cluster_user      => 'hzuser',
  cluster_password  => 'supersecret',
  cluster_members   => [
    '192.168.0.23',
    '192.168.0.24',
    '192.168.0.25'
  ]   
}
```

Of course we recomend you to configure the module using hiera, this is more reliable and flexible depending of your hierarchy, you can view the previous example here:

```yaml
---
  hazelcast::version: '3.9.3'
  hazelcast::root_dir: '/opt'
  hazelcast::config_dir: '/etc/hazelcast'
  hazelcast::service_ensure: 'running'
  hazelcast::manage_user: true
  hazelcast::user: 'hazelcast'
  hazelcast::group: 'hazelcast'
  hazelcast::download_url: 'http://download.hazelcast.com/download.jsp?verson=3.9.3&type=tar&p=28888'
  hazelcast::java_home: '/usr/lib/jvm/jre1.8.0'
  hazelcast::java_options: '-Dfoo=bar'
  hazelcast::classpath:
    - foo.jar
    - bar.jar
  hazelcast::cluster_discovery: 'tcp'
  hazelcast::cluster_user: 'hzuser'
  hazelcast::cluster_password: 'supersecret'
  hazelcast::cluster_members:
    - '192.168.0.23'
    - '192.168.0.24'
    - '192.168.0.25'
```

### Beginning with hazelcast

The very basic steps needed for a user to get the module up and running. This can include setup steps, if necessary, or it can be an example of the most basic use of the module.

## Usage


## Reference


## Limitations

The module supports only Debian systemd distributions: Stretch and Jessie, but we've plans to support another distrobutions that might compatible like CentOS 7 and Ubuntu in a near future (I hope). The configuration of the discovery
mechanims supports only TCP in the current version (0.2.0 at the time to write this)

## Development

Please feel free to send me your ideas in the form of pull requests, and fill an issue if you discover one

