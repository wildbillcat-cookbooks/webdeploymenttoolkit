Windows Web Deployment Toolkit Cookbook
===================================
Provides a set of Windows-specific primitives (Chef resources) meant to aid in the creation of cookbooks/recipes for .net applications targeting the Windows platform.

Requirements
-------------

### Tested Platforms
* Windows Server 2012 (R2)


### Cookbooks
The following cookbooks provided by Chef Software are required as noted:

* webpi (`webdeploymenttoolkit::default` leverages the webpi_product LWRP)


Attributes
----------
* `node['webdeploymenttoolkit']['WebDeployExe']` - used to execute the msdeploy.exe. default is %programfiles%\IIS\Microsoft Web Deploy V3\msdeploy.exe or %programfiles%\IIS\Microsoft Web Deploy V2\msdeploy.exe.


Resource/Provider
-----------------

### web_deploy

Not idempotent. Executes MsDeploy to sync packages, change settings, load packages into the IIS Server from a file, and performs any operations specified by the package.
See the following links for MSDN Documentation on it's use.
Web Deploy Operations: https://technet.microsoft.com/en-us/library/dd568989%28v=ws.10%29.aspx
Web Deploy Providers: https://technet.microsoft.com/en-us/library/dd569040%28v=ws.10%29.aspx

#### Actions
- :sync: Default. Syncs a deployment package to a target.
- :delete:  Deletes components targeted in the dest parameter
- :dump:  Runs the dump command with the xml flag. The dest is used to dump the output content
- :getDependencies:  Dumps application dependencies
- :getSystemInfo:  Dumps System information

#### Attribute Parameters
- source: name attribute. The source string as defined to a to the web deploy command line.
- dest: the destination string as defined to a to the web deploy command line.
- parameters: hash table of parameters and values that should be passed to msdeploy.
- param_file: string path to a parameter file.
- pre_sync: string to include a pre sync operation.
- post_sync: string to include a post sync operation.
- skip: array of values that should be passed to msdeploy's skip command.
- disable_link: array values that should be passed to msdeploy's disableLink command.
- enable_rule: array of values that should be passed to msdeploy's enableRule command.

#### Examples
```ruby
# Restore a Web Deploy Package
web_deploy "package=c:\dws.zip" do
	dest  'apphostconfig="Default Web Site"'
	action  :sync
end
```

```ruby
# Backup a Website to Web Deploy Package
web_deploy 'apphostconfig="Default Web Site"' do
	store_name  "package=c:\dws.zip"
	action  :sync
end
```

```ruby
# Deploy a Packaged Application with parameters
web_deploy 'package=c:\packagedApp.zip' do
	dest  'auto'
    parameters  ({ "IIS Web Application Name" => "Default Web Site/app", "connectionString" => "Database=stuff;user=me;pass=thing" })
	action  :sync
end
```

```ruby
# Remove OldApp1 application
web_deploy "DeleteOldApp1" do
    dest  'apphostconfig="MySite/OldApp1"'
	action :delete
end
```

```ruby
# Remove OldApp1 application
web_deploy "appPoolConfig" do
    dest  'C:/output/dump.xml'
	action :dump
end
```

```ruby
# Export Server Dependencies
web_deploy "webServer" do
    dest  'C:/output/WebServerDependencies.xml'
	action :getDependencies
end
```

```ruby
# Export System Info
web_deploy "webServerSystemInfo" do
    source  'webServer'
    dest  'C:/output/SystemInfo.xml'
	action :getSystemInfo
end
```
