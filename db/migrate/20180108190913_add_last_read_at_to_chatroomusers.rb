class AddLastReadAtToChatroomusers < ActiveRecord::Migration[5.1]
  def change
    add_column :chatroomusers, :last_read_at, :datetime
  end
end
