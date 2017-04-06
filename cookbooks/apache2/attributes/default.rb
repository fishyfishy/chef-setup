default['apache']['windows']['ftp_location']    = "ftp://peacefrog.saic.com/Users/MEDAL_OSS/Apache"
default['apache']['windows']['version']         = '2.4.25'
#TODO change path to not be on dev
default['apache']['windows']['dir']             = "C:/dev/Apache Software Foundation/Apache#{node['apache']['windows']['version']}"
default['apache']['windows']['extracted_dir']   = "#{node['apache']['windows']['dir']}/Apache24"
default['apache']['windows']['bin_dir']         = "#{node['apache']['windows']['extracted_dir']}/bin"
default['apache']['windows']['conf_dir']        = "#{node['apache']['windows']['extracted_dir']}/conf"
default['apache']['windows']['display_name']    = "Apache HTTP Server #{node['apache']['windows']['version']}"
default['apache']['windows']['package_name']    = "httpd-#{node['apache']['windows']['version']}-x64-vc14.zip"
default['apache']['windows']['ftp_install']     = "#{node['apache']['windows']['ftp_location']}/#{node['apache']['windows']['package_name']}"

default['apache']['windows']['mod_jk']          = 'mod_jk.so'
default['apache']['windows']['ftp_mod_jk']      = "#{node['apache']['windows']['ftp_location']}/#{node['apache']['windows']['mod_jk']}"

default['apache']['windows']['log_dir']         = 'logs' # relative to ServerRoot
default['apache']['windows']['error_log']       = 'error.log'
default['apache']['windows']['access_log']      = 'access.log'
default['apache']['windows']['user']            = 'daemon'
default['apache']['windows']['group']           = 'daemon'
default['apache']['windows']['service_name']    = "MEDALEA-Apache"
default['apache']['windows']['conf']            = "#{node['apache']['windows']['dir']}/conf/httpd.conf"
default['apache']['windows']['extras_dir']      = "#{node['apache']['windows']['dir']}/conf/extra"
default['apache']['windows']['binary']          = "#{node['apache']['windows']['bin_dir']}/httpd.exe"
default['apache']['windows']['docroot_dir']     = "#{node['apache']['windows']['dir']}/htdocs"
default['apache']['windows']['cgibin_dir']      = "#{node['apache']['windows']['dir']}/cgi-bin"
default['apache']['windows']['icondir']         = "#{node['apache']['windows']['dir']}/icons"
default['apache']['windows']['cache_dir']       = "#{node['apache']['windows']['dir']}/cache"
default['apache']['windows']['ssl_dir']         = "#{node['apache']['windows']['dir']}/ssl"
default['apache']['windows']['pid_file']        = "#{node['apache']['windows']['log_dir']}/httpd.pid"
default['apache']['windows']['mod_dir']         = "#{node['apache']['windows']['extracted_dir']}/modules"

default['apache']['windows']['service_user']    = "medaleaadmin"		#admin@#{node['fqdn']}"
default['apache']['windows']['pass']            = "Missconduct1@34"

default['apache']['windows']['default_modules'] = %w{ actions alias asis auth_basic authn_default authn_file authz_default authz_groupfile authz_host authz_user autoindex cgi dir env include isapi log_config mime negotiation setenvif }

# General settings
default['apache']['windows']['listen_ports']      = %w[80]
default['apache']['windows']['listen_addresses']  = %w[*]

# Extras to enable -- these correspond with the extras files that come out of the box
# Supported 'extras': autoindex, mpm, languages, userdir, info, manual, default, ssl
default['apache']['windows']['extras']            = []
