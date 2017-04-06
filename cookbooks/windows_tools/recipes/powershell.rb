# resources_directory = "#{Chef::Config['file_cache_path']}/resources"
#
# wmf5_location = "#{resources_directory}/#{node['WMF5']['windows']['filename']}"
#
# directory resources_directory do
#   recursive true
#   action :create
# end

######### UPDATE POWERSHELL #########

package node['WMF5']['windows']['package'] do
  action :nothing
  source node['WMF5']['windows']['url']
  installer_type :custom
  options node['WMF5']['windows']['options']
  guard_interpreter :powershell_script
  only_if "$PSVersionTable.PSVersion.Major -lt #{node['windows']['powershell']['version']}"
end
