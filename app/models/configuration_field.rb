class ConfigurationField < ActiveRecord::Base
	belongs_to :configuration_name
  	attr_accessible :name, :default_value, :state


  	scope :display, where(state: ["Mandatory", "Optional"])
  	scope :disabled_fields, where(state: "Disabled")
end
