class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :pay_type

      t.timestamps null: false
    end
  end
end
