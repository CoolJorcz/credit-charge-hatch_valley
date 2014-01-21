class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
    	t.integer :created, :limit => 8
    	t.boolean :paid, default: false
    	t.integer :amount
    	t.string :currency, null: false
    	t.boolean :refunded, null: false
    	t.references :customer
    	t.integer :dispute_date, :limit => 8, default: 0

      t.timestamps
    end
  end
end
