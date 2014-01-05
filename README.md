Description
===========

Manages installation of Elixir via packages or source.

Requirements
============

## Chef

Tested on Chef 11.8.2.

## Platform

Tested on:

* Ubuntu 12.04, 13.04
* CentOS 5.8, 6.4

**Notes**: This cookbook has been tested on the listed platforms. It may work on other platforms with or without modification.

## Cookbooks

* git
* erlang

Attributes
==========
By default, it downloads precompiled elixir files and install them in /usr/local path. It can be changed using the following attributes.

* `node['elixir']['install_path']` - installation path for elixir binaries and libraries
* `default['elixir']['install_method']` - installation method, which can be `source`, `precompiled` or `package`.
* `default[:elixir][:source][:revision]` - revision tag for the source installation.
* `default[:elixir][:precompiled][:revision]` - revision tag for the precompiled file installation.
* `default[:elixir][:package][:revision]` - revision tag for the package installation

### Note
#### Precompiled installation (install_method = precompiled)
Check the following for the list of the released versions.

- https://github.com/elixir-lang/elixir/releases

It installs the elixir files in to the following directories. In order to uninstall, remove these files.

- /usr/local/bin/
- /usr/local/lib/elixir/

#### Source Installation (install_method = source)
It downloads "elixir/master" by default. For installing specific revisions, check the GitHub page for the available ones.
- https://github.com/elixir-lang/elixir.git

#### Package installation (install_method = package)
##### Ubuntu
It's configured to uses the following PPA. In order to use different package, configure `node[:elixir][:package][:apt][***]` parameters.

- https://launchpad.net/~bigkevmcd/+archive/elixir

##### RHEL (CentOS)
It's configured to download the rpm file listed in the following. In order to use different ones, check `node[:elixir][:package][:yum][***]` parameters.

- http://rpm.pbone.net/

##### Others
- "esl" package is used for erlang installation by default, but it can be changed by changing `node[:elixir][:erlang_install_method]`
    - If the OS is RHEL5.x, "source" installation is forced, as esl package is not avialble.
