provides :web_deploy
actions :sync, :delete, :dump, :getDependencies, :getSystemInfo
default_action :sync

attribute :source, :kind_of => String, :name_attribute => true
attribute :dest, :kind_of => String
attribute :parameters, :kind_of => Hash
