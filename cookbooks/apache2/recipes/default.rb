require 'chef/exceptions'
require 'win32/service'

include_recipe 'windows_tools::carbon'

resources_directory = "#{Chef::Config['file_cache_path']}/resources"

apache_location = "#{resources_directory}/#{node['apache']['windows']['package_name']}"

unless node['platform_family'] == 'windows'
  raise Chef::Exceptions::Application, "This cookbook only works on Microsoft Windows."
end

directory node['apache']['windows']['dir'] do
  action :create
  recursive true
end

# Set Path for this process Win10 workaround
if not(ENV['Path'].include? "C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\")
  ENV['Path'] += ";C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\"
end

user node['apache']['windows']['service_user']  do
  password node['apache']['windows']['pass']
  notifies :run, "powershell_script[Grant #{node['apache']['windows']['service_user']} Logon Rights]", :immediately
end

powershell_script "Grant #{node['apache']['windows']['service_user']} Logon Rights" do
  action :nothing
  code <<-EOH
  Import-Module 'Carbon'
  Grant-Privilege -Identity #{node['apache']['windows']['service_user']} -Privilege SeServiceLogonRight
  EOH
end

# powershell_script  "Granting #{node['apache']['windows']['service_user']} Service Logon Rights" do
#   code <<-EOH
#   ntrights +r SeServiceLogonRight -u #{node['apache']['windows']['service_user']}
#   EOH
# end

directory resources_directory do
  action :create
  recursive true
end

remote_file apache_location do
  action :create
  source node['apache']['windows']['ftp_install']
end

execute "UnInstalling Apache Service #{node['apache']['windows']['service_name']}" do
  cwd node['apache']['windows']['bin_dir']
  command "httpd.exe -k uninstall -n #{node['apache']['windows']['service_name']}"
  only_if { ::Win32::Service.exists?(node['apache']['windows']['service_name']) }
  notifies :stop, "windows_service[#{node['apache']['windows']['service_name']}]", :before
  notifies :disable, "windows_service[#{node['apache']['windows']['service_name']}]", :before
end

windows_zipfile node['apache']['windows']['package_name'] do
  action :unzip
  path node['apache']['windows']['dir']
  overwrite true
  source apache_location
end

# Update and add the mod_jk.so for tunneling
remote_file "#{node['apache']['windows']['mod_dir']}/#{node['apache']['windows']['mod_jk']}" do
  source node['apache']['windows']['ftp_mod_jk']
end

template "#{node['apache']['windows']['conf_dir']}/httpd.conf" do
  source 'httpd.conf.erb'
end

template "#{node['apache']['windows']['conf_dir']}/extra/httpd-vhosts.conf" do
  source 'httpd-vhosts.conf.erb'
end

execute "Installing Apache Service #{node['apache']['windows']['service_name']}" do
  action :run
  cwd node['apache']['windows']['bin_dir']
  command "httpd.exe -k install -n #{node['apache']['windows']['service_name']}"
  not_if { ::Win32::Service.exists?(node['apache']['windows']['service_name']) }
end

# for the run_as_user property: use .\ in front of the username for local user accounts or specify the domain
windows_service node['apache']['windows']['service_name'] do
  action [:enable, :start]
  run_as_password node['apache']['windows']['pass']
  run_as_user ".\\#{node['apache']['windows']['service_user']}"
  only_if { ::Win32::Service.exists?(node['apache']['windows']['service_name']) }
end
