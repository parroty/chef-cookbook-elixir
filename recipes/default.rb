# Cookbook Name:: elixir
# Recipe:: default

# TODO: git::default didn't work in some OSs, and temporarily changed to git::source
include_recipe "git::source"

# install some packages required by erlang in advance, for avoiding timeout error during erlang installation.
if platform?('ubuntu')
  include_recipe 'apt'

  %w{default-jre-headless gcj-jre}.each do |pkg|
    package pkg do
      options "--fix-missing"
      action :install
    end
  end
end
if node['platform_family'] == 'rhel'
  Chef::Config[:yum_timeout] = node[:elixir][:yum_install_timeout]
end

if node['platform_family'] == 'rhel' and node['platform_version'].to_i <= 5
  # As RHEL5 doesn't have ESL package, force source installation.
  erlang_install_method = "source"
else
  erlang_install_method = node[:elixir][:erlang_install_method]
end

include_recipe "erlang::#{erlang_install_method}"
include_recipe "elixir::#{node[:elixir][:install_method]}"
