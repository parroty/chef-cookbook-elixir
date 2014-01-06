# Cookbook Name:: elixir
# Recipe:: source

#------- variables -------
# short alias for parameters
working_path = "#{Chef::Config[:file_cache_path]}/elixir"

#------- codes -------
git "elixir" do
  repository  node[:elixir][:source][:repo]
  revision    node[:elixir][:source][:revision]
  destination working_path
  action :sync
end

bash "install" do
  cwd working_path
  code <<-EOH
    make clean
    make
    make install PREFIX='#{node[:elixir][:install_path]}'
    EOH
  action :run
  not_if 'which elixir'
end
