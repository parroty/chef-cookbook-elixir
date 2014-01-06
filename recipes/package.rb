# Cookbook Name:: elixir
# Recipe:: package

case node['platform_family']
when 'debian'
  if platform?('ubuntu')
    package 'erlang-nox'
    package 'erlang-crypto'

    # replace ubuntu version with distributuion name
    case node['platform_version']
      when "13.10"
        dist_name = "saucy"
      when "12.10"
        dist_name = "quantal"
      when "12.04"
        dist_name = "precise"
      else
        dist_name = nil
    end

    # https://launchpad.net/~bigkevmcd/+archive/elixir
    apt_repository node[:elixir][:package][:apt][:name] do
      uri          node[:elixir][:package][:apt][:repo]
      distribution node[:elixir][:package][:apt][:distribution] || dist_name
      components   node[:elixir][:package][:apt][:components]
      keyserver    node[:elixir][:package][:apt][:keyserver]
      key          node[:elixir][:package][:apt][:key]
      action :add
    end

    package 'elixir' do
      version node[:elixir][:package][:revision]
      options "--force-yes"
      action :install
    end
  else
    Chef::Log.fatal('[:elixir][:install_method] is supported only for Ubuntu among debian family')
  end
when 'rhel'
  # http://rpm.pbone.net/
  rpm_file = "#{Chef::Config[:file_cache_path]}/#{node[:elixir][:package][:yum][:name]}"

  remote_file rpm_file do
    source "#{node[:elixir][:package][:yum][:repo]}/#{node[:elixir][:package][:yum][:name]}"
    action :create
  end

  rpm_package "elixir" do
    source rpm_file
    action :install
  end
else
  package "elixir"
end
