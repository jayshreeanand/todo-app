class AddMoreColumnsToTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :status, :integer, :default => 0
    add_column :tasks, :due_date, :datetime
    add_column :tasks, :time_required, :integer
    add_column :tasks, :time_taken, :integer
  end
end
