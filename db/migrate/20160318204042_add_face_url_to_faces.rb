class AddFaceUrlToFaces < ActiveRecord::Migration
  def change
    add_column :faces, :face_url, :string
  end
end
