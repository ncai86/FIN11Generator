class CreateBaseCurrencies < ActiveRecord::Migration
  def change
    create_table :base_currencies do |t|
      t.string :currency
      t.references :configuration_name
      
      t.timestamps
    end
  end
end
