class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :Subscriptions, :type, :plan
  end
end
