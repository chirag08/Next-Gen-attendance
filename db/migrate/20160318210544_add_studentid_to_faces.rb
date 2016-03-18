class AddStudentidToFaces < ActiveRecord::Migration
  def change
    add_column :faces, :student_id, :string
  end
end
