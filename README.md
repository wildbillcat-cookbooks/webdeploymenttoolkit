Windows Deployment Toolkit Cookbook
===================================
Provides a set of Windows-specific primitives (Chef resources) meant to aid in the creation of cookbooks/recipes targeting the Windows platform.

## Cookbooks

Attributes
----------
* `node['windows']['allow_pending_reboots']` - used to configure the `WindowsRebootHandler` (via the `windows::reboot_handler` recipe) to act on pending reboots. default is true (ie act on pending reboots).  The value of this attribute only has an effect if the `windows::reboot_handler` is in a node's run list.
* `node['windows']['allow_reboot_on_failure']` - used to register the `WindowsRebootHandler` (via the `windows::reboot_handler` recipe) as an exception handler too to act on reboots not only at the end of successful Chef runs, but even at the end of failed runs. default is false (ie reboot only after successful runs).  The value of this attribute only has an effect if the `windows::reboot_handler` is in a node's run list.


Resource/Provider
-----------------

### web_deploy

Installs a Web Deploy Package into the IIS Server from a file, and performs any operations specified by the package.  
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