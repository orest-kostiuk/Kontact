class AddStringIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :ids, :string
  end
end
