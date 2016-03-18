class RemoveUseridFromFaces < ActiveRecord::Migration
  def change
    remove_column :faces, :user_id, :string
  end
end
