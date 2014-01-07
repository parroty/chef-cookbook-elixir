# Cookbook Name:: elixir
# Recipe:: default

# TODO: git::default didn't work in some OSs, and temporarily changed to git::source
if node['platform_family'] == 'fedora'
  include_recipe "git::default"
else
  include_recipe "git::source"
end

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

# install erlang
if node[:elixir][:enable_erlang_install]
  # Force source installation, for platforms that ESL package is not available.
  if (node['platform_family'] == 'rhel' and node['platform_version'].to_i <= 5) or node['platform_family'] == 'fedora'
    erlang_install_method = "source"
    node.default[:erlang][:source][:version] = node[:elixir][:erlang_source_version]
    node.default[:erlang][:source][:url]     = node[:elixir][:erlang_source_url]
  else
    erlang_install_method = node[:elixir][:erlang_install_method]
  end

  include_recipe "erlang::#{erlang_install_method}"
end

include_recipe "elixir::#{node[:elixir][:install_method]}"
