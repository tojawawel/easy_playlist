class AddPlaylistNameToImportFile < ActiveRecord::Migration[6.0]
  def change
    add_column :import_files, :playlist_name, :string
  end
end
