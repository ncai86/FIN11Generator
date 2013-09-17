class CreateAcquirers < ActiveRecord::Migration
  def change
    create_table :acquirers do |t|
      t.string :name
      t.string :code
      t.references :base_currency

      t.timestamps
    end
  end
end
