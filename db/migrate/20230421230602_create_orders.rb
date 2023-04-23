class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id,    null: false
      t.integer :postage,        null: false
      t.integer :payment_method, default: 0, null: false # 0=クレジットカード,1=銀行振込,enumで管理
      t.integer :total_price,    null: false
      t.string  :name,           null: false
      t.string  :postal_code,    null: false
      t.string  :address,        null: false
      t.integer :order_status,   default: 0, null: false # 0=入金待ち,1=入金確認,2=製作中,3=発送準備中,4=発送済み, enumで管理

      t.timestamps
    end
  end
end
