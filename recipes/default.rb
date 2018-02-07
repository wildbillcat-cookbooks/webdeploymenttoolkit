#
# Cookbook Name:: webdeploymenttoolkit
# Recipe:: default
#
# Install MSDeploy through Microsoft Web Platform Installer
include_recipe 'webpi'

webpi_product 'WDeployNoSMO' do
  accept_eula true
  action :install
end
