Windows Deployment Toolkit Cookbook
===================================
Provides a set of Windows-specific primitives (Chef resources) meant to aid in the creation of cookbooks/recipes targeting the Windows platform.

### Cookbooks
The following cookbooks provided by Chef Software are required as noted:

* chef_handler (`windows::reboot_handler` leverages the chef_handler LWRP)

Attributes
----------
* `node['windows']['allow_pending_reboots']` - used to configure the `WindowsRebootHandler` (via the `windows::reboot_handler` recipe) to act on pending reboots. default is true (ie act on pending reboots).  The value of this attribute only has an effect if the `windows::reboot_handler` is in a node's run list.
* `node['windows']['allow_reboot_on_failure']` - used to register the `WindowsRebootHandler` (via the `windows::reboot_handler` recipe) as an exception handler too to act on reboots not only at the end of successful Chef runs, but even at the end of failed runs. default is false (ie reboot only after successful runs).  The value of this attribute only has an effect if the `windows::reboot_handler` is in a node's run list.


Resource/Provider
-----------------

### web_deploy

Installs a Web Deploy Package into the IIS Server from a file, and performs any operations specified by the package.

#### Actions
- :sync: syncs a deployment package to a target.
- :delete: deletes a certificate.
- :acl_add: adds read-only entries to a certificate's private key ACL.

#### Attribute Parameters
- source: name attribute. The source file (for create and acl_add), thumprint (for delete and acl_add) or subject (for delete).
- pfx_password: the password to access the source if it is a pfx file.
- private_key_acl: array of 'domain\account' entries to be granted read-only access to the certificate's private key. This is not idempotent.
- store_name: the certificate store to maniplate. One of MY (default : personal store), CA (trusted intermediate store) or ROOT (trusted root store).
- user_store: if false (default) then use the local machine store; if true then use the current user's store.

#### Examples
```ruby
# Add PFX cert to local machine personal store and grant accounts read-only access to private key
web_deploy "c:/test/mycert.pfx" do
	pfx_password	"password"
	private_key_acl	["acme\fred", "pc\jane"]
end
```

```ruby
# Add cert to trusted intermediate store
web_deploy "c:/test/mycert.cer" do
	store_name	"CA"
end
```

```ruby
# Remove all certicates matching the subject
web_deploy "me.acme.com" do
	action :delete
end
```

