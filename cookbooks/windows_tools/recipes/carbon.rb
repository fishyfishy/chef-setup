require 'fileutils'

include_recipe 'windows_tools::powershell'

######### Install Carbon #########

windows_zipfile node['carbon']['windows']['filename'] do
  action :unzip
  path node['carbon']['windows']['extract_path']
  overwrite true
  source node['carbon']['windows']['url']
  not_if { ::File.directory? node['carbon']['windows']['extract_path']}
end
#TODO Improve gaurd to use checksum

directory node['carbon']['windows']['module_path'] do
  recursive true
  action :create
end

ruby_block 'Install Carbon' do
  block do
    FileUtils.cp_r("#{node['carbon']['windows']['extract_path']}\\Carbon", node['carbon']['windows']['module_path'])
  end
  not_if { ::File.exist? "#{node['carbon']['windows']['module_path']}\\Carbon\\bin\\Carbon.dll" }
end
