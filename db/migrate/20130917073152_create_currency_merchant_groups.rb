class CreateCurrencyMerchantGroups < ActiveRecord::Migration
  def change
    create_table :currency_merchant_groups do |t|
      t.string :name
      t.integer :group_id
      t.references :acquirer

      t.timestamps
    end
  end
end
