class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :user,      null: false, foreign_key: true
      t.references :card,      null: false, foreign_key: true
      t.string :token,         null: false
      t.references :customer,  null: false

      t.timestamps
    end
  end
end
