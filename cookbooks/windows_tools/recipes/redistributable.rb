# resources_directory = "#{Chef::Config['file_cache_path']}/resources"
#
# redist_location = "#{resources_directory}/#{node['2015Redistributable']['windows']['filename']}"
#
# directory resources_directory do
#   recursive true
#   action :create
# end

######### INSTALL 2015 Redistributable #########

package node['2015Redistributable']['windows']['package'] do
  action :install
  source node['2015Redistributable']['windows']['url']
  installer_type :custom
  options node['2015Redistributable']['windows']['options']
end
