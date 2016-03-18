class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :roll_num
      t.string :class_name

      t.timestamps null: false
    end
  end
end
