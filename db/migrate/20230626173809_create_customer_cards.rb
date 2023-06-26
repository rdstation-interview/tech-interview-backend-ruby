class CreateCustomerCards < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
    end

    create_table :cards do |t|
      t.string :card_number
      t.references :customer

      t.timestamps
    end
  end
end
