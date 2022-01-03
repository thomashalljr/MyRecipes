class DropStocks < ActiveRecord::Migration[5.1]
  def up
    drop_table :stocks if table_exists? :stocks
  end

  def down
    create_table :stocks do |t|
      t.string   :ticker
      t.string   :name
      t.decimal  :last_price

      t.timestamps
    end
  end
end
