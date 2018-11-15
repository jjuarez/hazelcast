# Changelog

All notable changes to this project will be documented in this file.

## Release 0.6.3

## Features
* Extends the tests to cover the corner case with the dependency between the user an its group

## Release 0.6.1

## Features
* Makes configuration some custom parameters of the hazelcast servers using systemd as init system, allows you to configure a 
custom sucessfull exit code and the time to wait during the restart operations of the service

## Release 0.6.2

## Features
* Fixes the issue with the bad dependency between the hazelcast user and group

## Release 0.6.1

## Features
* Makes configuration some custom parameters of the hazelcast servers using systemd as init system, allows you to configure a 
custom sucessfull exit code and the time to wait during the restart operations of the service

## Bugfixes
* Solves the fault status of the systemd unit after an stop operation, because hazelcast use to exist with an exit code different than 0, amazing

## Release 0.6.0

## Features
* Makes optional the installation of the client console stuff
* New approach with the systemd, avoiding the use of additional files to store enviroment variables, you can read more about this subject [here](https://unix.stackexchange.com/questions/418851/location-to-place-systemd-service-environmentfile-when-creating-debian-package)

## Bugfixes
* Solves an issue related with the service subscription

## Release 0.5.2

## Features

## Bugfixes
* Solves an issue related with the systemd unit file permissions

## Release 0.5.1

## Features

## Bugfixes
* Solves mainly some documentation isssues

## Release 0.5.0

## Features
* Adds support for a bunch of Linux distribution which support systemd as init, AYMK:
 
 * Ubuntu 16.04, 18.04, 18.10
 * Archlinux 4

* Increases the test coverage

## Bugfixes

## Release 0.4.1

## Features
* No functional additions, only documentation issues solved

## Bugfixes

## Release 0.4.0

## Features
* Adds the simples example possible to the documentation
* Adds AWS discovery capabilities

## Bugfixes
* Doc: Solves a small issue in the README.md file

## Release 0.3.2

## Features
* Adds the capability of configure the cluster discovery with multicast
* Adds some new configuration examples

## Bugfixes

* Solves some issues with the module URLs in the metadata.json file
* Solves some errors in the documentation of the module

## Release 0.3.1

### Features

* Add the capability to configure a management center

### Bugfixes

## Release 0.2.11

### Features
Now the module supports the configuration of these parameters:

* time-to-live-seconds, to configure a general TTL, and avoid the 'infinite' policy
* A set of specific TTL

## Release 0.2.10

### Features

### Bugfixes

* The relation of dependency between the service resource and the file for the systemd unit was wrong and this provoked the fail of the puppet catalogs

## Release 0.2.9

### Features

### Bugfixes

## Release 0.2.8

### Features

### Bugfixes

## Release 0.2.7

### Features

### Bugfixes

## Release 0.2.6

### Features

* Changes in the URL of the repository, now with the puppet prefix
* Support for the CentOS 7 release (easy-peasy)

### Bugfixes

* Look over the documentation

## Release 0.2.5

### Features

### Bugfixes

* The parameters of the module follow the cluster group configuration parameter names, like group.name and group.password, instead of user and password

## Release 0.2.4

### Features

* Include the support for a small CLI tool that may help you to conect with your cluster and do some tests, the client configuration needed to connect with the cluster is automatically provided too by the module
* Better naming for the hazelcast cluster groups variable names
* Avoid the use of the (damned) exec resource

## Release 0.2.3

### Features

There're not features in this release, I'm just to adjust the java environment to the minimun required

### Bugfixes

* The systemd unit needs an absolute name for the java executable

## Release 0.2.2 [Deleted]

### Features

### Bugfixes

## Release 0.2.1

### Features

This version does not add new features per se, but adds some new interesting interfaces that brings to the module the path to grow

### Bugfixes

* Solves this issue <https://gitlab.com/homeWiFi-devops/hazelcast/issues/1>

## Release 0.2.0

### Features

You can call this the first release of the module, it includes the next features:

* Supports (only) the TCP discovery mechanism, but this is the begining
* Solves the issue with the logging configuration of the process

### Bugfixes

## Release 0.1.1

### Features

### Bugfixes

* A shilly issue related with the module metadata.json file

## Release 0.1.0

### Features

Implements only the basics to support the process up and running

### Bugfixes

### Known Issues
