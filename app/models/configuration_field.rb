class ConfigurationField < ActiveRecord::Base
	belongs_to :configuration_name
  	attr_accessible :name, :default_value, :state

  	validates :name, presence: true

  	scope :display, where(state: ["Mandatory", "Optional"])
end
