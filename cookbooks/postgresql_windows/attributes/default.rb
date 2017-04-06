
### POSTGRESQL attrbiutes ###
default['postgresql']['package']['version']         = '9.6'
default['postgresql']['version']                    = "#{default['postgresql']['package']['version']}.1-1"
default['postgresql']['windows']['package']         = "PostgreSQL #{node['postgresql']['package']['version']}"
default['postgresql']['windows']['filename']        = "postgresql-#{node['postgresql']['version']}-windows-x64.exe"
default['postgresql']['windows']['reg_entry']       = "HKLM:\\Software\\PostgreSQL\\Installations\\*"
default['postgresql']['windows']['url']             = "ftp://peacefrog.saic.com/Users/MEDAL_OSS/#{node['postgresql']['windows']['filename']}"

default['postgresql']['admin']['username']          = 'postgres'
default['postgresql']['admin']['password']          = 'Mars1000'

### POSTGRESQL Silent Install Options ###
default['postgresql']['options']['servicename']     = 'medal_postgres'
default['postgresql']['options']['serviceaccount']  = 'medal_pg'
default['postgresql']['options']['servicepassword'] = 'Missconduct1@34'

default['postgresql']['options']['install_dir']     = "C:\\Program Files\\PostgreSQL\\#{node['postgresql']['package']['version']}"
default['postgresql']['options']['data_dir']        = "#{node['postgresql']['package']['version']}\\data"

default['postgresql']['options']['serverport']      = '5432'

default['postgresql']['options']['port']            = "--serverport #{node['postgresql']['options']['serverport']}"
default['postgresql']['options']['unattented']      = '--unattendedmodeui minimal --mode unattended'
default['postgresql']['options']['service']         = "--servicename #{node['postgresql']['options']['servicename']} --serviceaccount #{node['postgresql']['options']['serviceaccount']} --servicepassword #{node['postgresql']['options']['servicepassword']}"
default['postgresql']['options']['superaccount']    = "--superaccount #{node['postgresql']['admin']['username']} --superpassword #{node['postgresql']['admin']['password']}"

# Silent Install options for service and port left to default
default['postgresql']['silent_install']['options']  = "#{node['postgresql']['options']['unattented']} #{node['postgresql']['options']['superaccount']}"

### POSTGIS attributes ###
default['postgis']['version']['major']              = '2.3'
default['postgis']['package']['version']            = '2.3.1'
default['postgis']['version']['long']               = "#{default['postgis']['package']['version']}-1"
default['postgis']['windows']['package']            = "PostGIS #{node['postgis']['version']['long']} for PostgreSQL x64 #{default['postgresql']['package']['version']} (remove only)"
default['postgis']['windows']['filename']           = "postgis-bundle-pg96x64-setup-#{node['postgis']['version']}.exe"
default['postgis']['windows']['reg_entry']          = "HKLM:\\Software\\PostGIS\\#{node['postgis']['version']['major']}\\*"
default['postgis']['windows']['url']                = "ftp://peacefrog.saic.com/Users/MEDAL_OSS/#{node['postgis']['windows']['filename']}"

default['postgis']['silent_install']['options']     = "/S /D=#{node['postgresql']['options']['install_dir']}"
