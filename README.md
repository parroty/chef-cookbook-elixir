Description
===========

Manages installation of Elixir via packages or source.

Requirements
============

## Chef

Tested on Chef 11.8.2.

## Platform

Tested on:

* Ubuntu 12.04, 13.04, 13.10
* CentOS 5.8, 6.4

**Notes**: This cookbook has been tested on the listed platforms, but not with the all combinations of parameters. It may work on other platforms with or without modification.

## Cookbooks

* git
* erlang

### Berksfile
As an example, the following berksfile would work.

```
site :opscode

cookbook 'git'
cookbook 'erlang', git: 'https://github.com/opscode-cookbooks/erlang.git'
cookbook 'elixir', git: 'https://github.com/parroty/chef-cookbook-elixir.git'
```

Attributes
==========
By default, it downloads precompiled elixir files and install them in /usr/local path. It can be changed using the following attributes.

* `node['elixir']['install_path']` - installation path for elixir binaries and libraries
* `default['elixir']['install_method']` - installation method, which can be `source`, `precompiled` or `package`.
* `default[:elixir][:source][:revision]` - revision tag for the source installation.
* `default[:elixir][:precompiled][:revision]` - revision tag for the precompiled file installation.
* `default[:elixir][:package][:apt][:revision]` - revision tag for the Ubuntu package installation.
* `default[:elixir][:package][:yum][:revision]` - revision tag for the RHEL package installation.

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
It's tested on 13.10 (Saucy), and it might not work on older versions.

- https://launchpad.net/~bigkevmcd/+archive/elixir

##### RHEL (CentOS)
It's configured to download the rpm file listed in the following. In order to use different ones, check `node[:elixir][:package][:yum][***]` parameters.

- http://rpm.pbone.net/

It may not work on RHEL 5.x, due to the dependency related issue, use `source` or `precompiled` instead.

#### Erlang installation
- By default, this cookbook tries to install erlang for ensuring elixir's requirement is satisfied (as many of the default packages installs old erlang, yet). If it's not needed, specify `false` for `node[:elixir][:enable_erlang_install]` attribute.
- "esl" package is used for erlang installation by default, but it can be changed by changing `node[:elixir][:erlang_install_method]`.
    - If the OS is RHEL5.x, "source" installation is forced, as esl package is not avialble.


### Vagrant
Some Vagrantfile definition exapmles.

- Source installation of elixir (elixir/master)

```ruby
config.vm.provision :chef_solo do |chef|
    chef.add_recipe "elixir::default"
    chef.json = {
      "elixir" => {
        "install_method" => "source"
      }
    }
```

- Package installation of elixir

```ruby
config.vm.provision :chef_solo do |chef|
    chef.add_recipe "elixir::default"
    chef.json = {
      "elixir" => {
        "install_method" => "package"
      }
    }
```
