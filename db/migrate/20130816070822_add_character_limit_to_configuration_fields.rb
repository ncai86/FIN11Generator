class AddCharacterLimitToConfigurationFields < ActiveRecord::Migration
  def change
  	add_column :configuration_fields, :character_limit, :integer
  end
end
