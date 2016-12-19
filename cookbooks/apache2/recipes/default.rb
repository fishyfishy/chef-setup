require 'chef/exceptions'

unless node['platform_family'] == 'windows'
  raise Chef::Exceptions::Application, "This cookbook only works on Microsoft Windows."
end

directory node['apache']['windows']['dir'] do
  recursive true
  action :create
end

zipfile node['apache']['windows']['source'] do
  into node['apache']['windows']['dir']
end

log 'UNZIPPED' do
  message "Apache has been unzipped to: #{node['apache']['windows']['dir']}"
  level :info
end

execute "Installing Service #{node['apache']['windows']['serivce_name']}" do
   command "sc.exe create #{node['apache']['windows']['serivce_name']} binPath= \"#{node['apache']['windows']['binary']}\""
   action :run
   notifies :run, "execute[Setting Log On User For #{node['apache']['windows']['serivce_name']}]", :immediately
end

execute "Setting Log On User For #{node['apache']['windows']['serivce_name']}" do
   command "sc.exe config \"#{node['apache']['windows']['serivce_name']}\" obj= #{node['apache']['windows']['serveradmin']} password= #{node['apache']['windows']['pass']}"
   action :nothing
end

service "apache2" do
  service_name "#{node['apache']['windows']['serivce_name']}"
  action [:enable, :start]
end
