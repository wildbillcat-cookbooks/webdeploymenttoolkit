
use_inline_resources

provides :web_deploy

action :sync do
  msdeploy_cmd = "#{node['webdeploymenttoolkit']['WebDeployExe']} "
  msdeploy_cmd << '-verb:sync '
  msdeploy_cmd << "-source:#{@new_resource.source} " unless @new_resource.source.nil?
  msdeploy_cmd << "-dest:#{@new_resource.dest} " unless @new_resource.dest.nil?
  msdeploy_cmd << "-setParamFile:#{@new_resource.param_file} " unless @new_resource.param_file.nil?
  msdeploy_cmd << "-postSync:#{@new_resource.post_sync} " unless @new_resource.post_sync.nil?
  msdeploy_cmd << "-preSync:#{@new_resource.pre_sync} " unless @new_resource.pre_sync.nil?

  @new_resource.parameters.each do |name, value|
    msdeploy_cmd << "-setParam:name=\"#{name}\",value=\"#{value}\" "
  end unless @new_resource.parameters.nil?

  @new_resource.skip.each do |attribute, value|
    msdeploy_cmd << "-skip:#{attribute}=#{value} "
  end unless @new_resource.skip.nil?

  @new_resource.disable_link.each do |value|
    msdeploy_cmd << "-disableLink:#{value} "
  end unless @new_resource.disable_link.nil?

  @new_resource.enable_rule.each do |value|
    msdeploy_cmd << "-enableRule:#{value} "
  end unless @new_resource.enable_rule.nil?

  Chef::Log.info('Execute MSDeploy Sync')

  execute 'webdeploy' do
    command msdeploy_cmd
  end
end

# msdeploy -verb:delete -dest:apphostconfig="MySite/OldApp1"
action :delete do
  msdeploy_cmd = "#{node['webdeploymenttoolkit']['WebDeployExe']} "
  msdeploy_cmd << '-verb:delete '
  msdeploy_cmd << "-dest:#{@new_resource.dest} " unless @new_resource.dest.nil?

  Chef::Log.info('Execute MSDeploy Delete')

  execute 'webdeploy' do
    command msdeploy_cmd
  end
end

#msdeploy �verb:dump �source:appHostConfig="Default Web Site" -xml
action :dump do
  msdeploy_cmd = "#{node['webdeploymenttoolkit']['WebDeployExe']} "
  msdeploy_cmd << '-verb:dump '
  msdeploy_cmd << "-source:#{@new_resource.source} " unless @new_resource.source.nil?
  msdeploy_cmd << '-xml '
  msdeploy_cmd << ">> #{@new_resource.dest} " unless @new_resource.dest.nil?

  Chef::Log.info('Execute MSDeploy dump')

  execute 'webdeploy' do
    command msdeploy_cmd
  end
end

# msdeploy -verb:getDependencies -source:webServer
action :getDependencies do
  msdeploy_cmd = "#{node['webdeploymenttoolkit']['WebDeployExe']} "
  msdeploy_cmd << '-verb:getDependencies '
  msdeploy_cmd << "-source:#{@new_resource.source} " unless @new_resource.source.nil?
  msdeploy_cmd << ">> #{@new_resource.dest} " unless @new_resource.dest.nil?

  Chef::Log.info('Execute MSDeploy getDependencies')

  execute 'webdeploy' do
    command msdeploy_cmd
  end
end

# msdeploy -verb:getsysteminfo -source:webServer
action :getSystemInfo do
  msdeploy_cmd = "#{node['webdeploymenttoolkit']['WebDeployExe']} "
  msdeploy_cmd << '-verb:getsysteminfo '
  msdeploy_cmd << "-source:#{@new_resource.source} " unless @new_resource.source.nil?
  msdeploy_cmd << ">> #{@new_resource.dest} " unless @new_resource.dest.nil?

  Chef::Log.info('Execute MSDeploy getSystemInfo')

  execute 'webdeploy' do
    command msdeploy_cmd
  end
end
