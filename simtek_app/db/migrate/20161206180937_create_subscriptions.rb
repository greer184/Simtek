class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :group
      t.string :type
      t.date :date
      t.integer :payment

      t.timestamps null: false
    end
  end
end
