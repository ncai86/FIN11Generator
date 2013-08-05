class CreateConfigurationFields < ActiveRecord::Migration
  def change
    create_table :configuration_fields do |t|
    	t.string :name
    	t.string :default_value
    	t.string :state
    	t.references :configuration_name

      	t.timestamps
    end
  end
end
