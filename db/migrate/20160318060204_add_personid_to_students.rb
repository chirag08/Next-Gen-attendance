class AddPersonidToStudents < ActiveRecord::Migration
  def change
    add_column :students, :person_id, :string
  end
end
