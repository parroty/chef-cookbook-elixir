# Cookbook Name:: elixir
# Attributes:: default

default[:elixir][:install_path] = "/usr/local"
default[:elixir][:install_method] = "precompiled"

default[:elixir][:source][:repo] = "https://github.com/elixir-lang/elixir.git"
default[:elixir][:source][:revision] = "master"

default[:elixir][:precompiled][:repo] = "https://github.com/elixir-lang/elixir/releases/download"
default[:elixir][:precompiled][:revision] = "v0.12.0"

default[:elixir][:package][:revision] = "0.12.0-0"

default[:elixir][:package][:apt][:repo] = "http://ppa.launchpad.net/bigkevmcd/elixir/ubuntu"
default[:elixir][:package][:apt][:name] = "bigkevmcd"
default[:elixir][:package][:apt][:components] = ["main"]
default[:elixir][:package][:apt][:distribution] = nil
default[:elixir][:package][:apt][:key] = "72D340A3"
default[:elixir][:package][:apt][:keyserver] = "keyserver.ubuntu.com"

default[:elixir][:package][:yum][:repo] = "ftp://ftp.univie.ac.at/systems/linux/fedora/updates/20/x86_64"
default[:elixir][:package][:yum][:name] = "elixir-0.12.0-1.fc20.noarch.rpm"

# do not change
default[:elixir][:erlang_install_method] = "esl"
