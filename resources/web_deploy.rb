provides :web_deploy
actions :sync, :delete, :dump, :getDependencies, :getSystemInfo
default_action :sync

attribute :source, kind_of: String, name_attribute: true
attribute :dest, kind_of: String
attribute :param_file, kind_of: String
attribute :post_sync, kind_of: String
attribute :pre_sync, kind_of: String
attribute :skip, kind_of: Hash
attribute :disable_link, kind_of: Array
attribute :enable_rule, kind_of: Array
attribute :parameters, kind_of: Hash
