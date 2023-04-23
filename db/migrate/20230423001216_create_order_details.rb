class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :amount, null: false
      t.integer :making_status, default: 0, null: false # 0=着手不可,1=製作待ち,2=製作中,3=製作完了,
      t.integer :ordered_price, null: false

      t.timestamps
    end
  end
end
