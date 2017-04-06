#
# Cookbook:: postgresql_windows
# Recipe:: default
#
# Copyright:: 2016, Matt Mason, All Rights Reserved.

windows_package node['postgresql']['windows']['package'] do
    action :install
    source node['postgresql']['windows']['url']
    installer_type :custom
    options node['postgresql']['silent_install']['options']
    guard_interpreter :powershell_script
    only_if "( Get-ItemProperty #{node['postgresql']['windows']['reg_entry']} | ForEach-Object {$_.Version} ) -lt \"#{node['postgresql']['version']}\""
end

windows_package node['postgis']['windows']['package'] do
    action :install
    source node['postgis']['windows']['url']
    installer_type :custom
    options node['postgis']['silent_install']['options']
    guard_interpreter :powershell_script
    only_if "( Get-ItemProperty #{node['postgis']['windows']['reg_entry']} | ForEach-Object {$_.Version} ) -lt \"#{node['postgis']['version']}\""
end
