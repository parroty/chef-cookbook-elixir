# Cookbook Name:: elixir
# Recipe:: precompiled

#------- variables -------
# short alias for parameters
install_path = node[:elixir][:install_path]
revision     = node[:elixir][:precompiled][:revision]

# paths
archive_source       = "#{node[:elixir][:precompiled][:repo]}/#{revision}/Precompiled.zip"
archive_destination  = "#{Chef::Config[:file_cache_path]}/elixir_precompiled"
archive_save_path    = "#{archive_destination}/precompiled.zip"
archive_extract_path = "#{archive_destination}/extract"

# target files
target_libs = %w{eex elixir ex_unit iex mix logger}
target_bins = %w{elixir elixirc iex mix}

#------- codes -------
# Install prerequisite packages.
package "unzip" do
  action :install
end

# Download precompiled archive from the official GitHub repository.
directory archive_destination do
  mode 0755
  action :create
end

remote_file archive_save_path do
  source archive_source
end

# Unzip the precompiled archive file.
bash "unzip" do
  code <<-EOH
    unzip -u #{archive_save_path} -d #{archive_extract_path}
    EOH
  action :run
  not_if { ::File.exists?(archive_extract_path) }
end

# Install lib files
target_libs.each do |dir|
  bash "install lib/#{dir}" do
    cwd archive_extract_path
    code <<-EOH
      install -m755 -d #{install_path}/lib/elixir/lib/#{dir}/ebin
      install -m644 lib/#{dir}/ebin/* #{install_path}/lib/elixir/lib/#{dir}/ebin
      EOH
    action :run
    not_if { ::File.exists?("#{install_path}/lib/elixir/lib/#{dir}/ebin") }
  end
end

# Install bin files
bash "create target bin dirs" do
  code <<-EOH
    install -m755 -d #{install_path}/lib/elixir/bin
    install -m755 -d #{install_path}/bin
    EOH
  action :run
end

target_bins.each do |file|
  bash "install bin/#{file}" do
    cwd archive_extract_path
    code "install -m755 bin/#{file} #{install_path}/lib/elixir/bin"
    action :run
    not_if { ::File.exists?("#{install_path}/lib/elixir/bin/#{file}") }
  end

  link "#{install_path}/bin/#{file}" do
    to "#{install_path}/lib/elixir/bin/#{file}"
  end
end
