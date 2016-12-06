class AddSubscriptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :subscription, :string
  end
end
