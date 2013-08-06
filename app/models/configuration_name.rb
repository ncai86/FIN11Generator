class ConfigurationName < ActiveRecord::Base
	has_many :configuration_fields, :dependent => :destroy
  	attr_accessible :name

  	validates :name, presence: true
end
