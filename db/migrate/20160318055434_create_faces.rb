class CreateFaces < ActiveRecord::Migration
  def change
    create_table :faces do |t|
      t.string :face_id
      t.string :user_id

      t.timestamps null: false
    end
  end
end
