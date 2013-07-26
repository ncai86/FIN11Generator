class CreateFormFields < ActiveRecord::Migration
  def change
    create_table :form_fields do |t|

      t.timestamps
    end
  end
end
