actions :sync, :delete, :dump, :getDependencies, :getSystemInfo

attribute :source, :kind_of => String, :name_attribute => true
attribute :dest, :kind_of => String
attribute :parameters, :kind_of => Hash

def initialize(name, run_context=nil)
  super
  @action = :sync
end