# Changelog

All notable changes to this project will be documented in this file.


## Release 0.1.0

**Features**

Implements only the basics to support the process up and running

**Bugfixes**

**Known Issues**


## Release 0.1.1

**Features**

**Bugfixes**
* A shilly issue related with the module metadata.json file


## Release 0.2.0

**Features**
You can call this the first release of the module, it includes the next features:

* Supports (only) the TCP discovery mechanism, but this is the begining
* Solves the issue with the logging configuration of the process

**Bugfixes**


## Release 0.2.1

**Features**
This version does not add new features per se, but adds some new interesting interfaces that brings to the module the path to grow 

**Bugfixes**

* Solves this issue https://gitlab.com/homeWiFi-devops/hazelcast/issues/1


## Release 0.2.2 [Deleted]

**Features**

**Bugfixes**


## Release 0.2.3

**Features**
There're not features in this release, I'm just to adjust the java environment to the minimun required

**Bugfixes**

* The systemd unit needs an absolute name for the java executable


## Release 0.2.4

**Features**

* Include the support for a small CLI tool that may help you to conect with your cluster and do some tests, the client configuration needed to connect with the cluster is automatically provided too by the module
* Better naming for the hazelcast cluster groups variable names
* Avoid the use of the (damned) exec resource

**Bugfixes**


## Release 0.2.5

**Features**

**Bugfixes**

 * The parameters of the module follow the cluster group configuration parameter names, like group.name and group.password, instead of user and password


## Release 0.2.6

**Features**

 * Changes in the URL of the repository, now with the puppet prefix
 * Support for the CentOS 7 release (easy-peasy)

**Bugfixes**

 * Look over the documentation
