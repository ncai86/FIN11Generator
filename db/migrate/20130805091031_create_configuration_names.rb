class CreateConfigurationNames < ActiveRecord::Migration
  def change
    create_table :configuration_names do |t|
    	t.string :name 

      	t.timestamps
    end
  end
end
