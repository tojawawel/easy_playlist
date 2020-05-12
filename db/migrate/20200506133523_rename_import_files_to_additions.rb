class RenameImportFilesToAdditions < ActiveRecord::Migration[6.0]
  def change
    rename_table :import_files, :additions
  end
end
