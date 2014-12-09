class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.references :user, index: true
      t.timestamps
    end
  end
end
