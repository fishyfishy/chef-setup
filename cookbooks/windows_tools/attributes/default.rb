default['2015Redistributable']['windows']['filename']  = 'vc_redist.x64.exe'
default['2015Redistributable']['windows']['package']   = 'Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.23026'
default['2015Redistributable']['windows']['options']   = "/quiet /norestart"

default['carbon']['windows']['filename']               = 'Carbon-2.4.0.zip'
default['carbon']['windows']['package']                = "Carbon"
default['carbon']['windows']['extract_path']           = "C:\\dev\\#{node['carbon']['windows']['package']}"
###### For Development usage #######
default['carbon']['windows']['module_path']            = 'C:\DevTools\opscode\chefdk\modules'
###### For Environment usage #######
# default['carbon']['windows']['module_path']            = 'C:\EnvTools\opscode\chef\modules'
default['carbon']['windows']['import_script']          = '.\Carbon\Import-Carbon.ps1'

default['WMF5']['windows']['filename']                 = 'Win7AndW2K8R2-KB3134760-x64.msu'
default['WMF5']['windows']['package']                  = "Windows Management Framework 5"
default['WMF5']['windows']['options']                  = "/quiet /norestart"

default['windows']['powershell']['version']            = '5'

default['ftp']['base']['url']                          = "ftp://peacefrog.saic.com/Users/MEDAL_OSS"

default['2015Redistributable']['windows']['url']       = "#{node['ftp']['base']['url']}/2015Redistributable/#{node['2015Redistributable']['windows']['filename']}"
default['WMF5']['windows']['url']                      = "#{node['ftp']['base']['url']}/WindowsManagementFramework5/#{node['WMF5']['windows']['filename']}"
default['carbon']['windows']['url']                    = "#{node['ftp']['base']['url']}/#{node['carbon']['windows']['filename']}"
