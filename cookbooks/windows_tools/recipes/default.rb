#
# Cookbook:: windows_tools
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'windows_tools::powershell'
include_recipe "windows_tools::carbon"
include_recipe "windows_tools::redistributable"
