# Cookbook Name:: elixir
# Recipe:: default

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

include_recipe "git::source"
include_recipe "erlang::#{node[:elixir][:erlang_install_method]}"
include_recipe "elixir::#{node[:elixir][:install_method]}"
