class ConfigurationName < ActiveRecord::Base
	has_many :configuration_fields, :dependent => :destroy
	has_many :base_currencies, :dependent => :destroy
  	attr_accessible :name

  	validates :name, presence: true
end
