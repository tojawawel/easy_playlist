class AddAttachmentDataToImportFiles < ActiveRecord::Migration[6.0]
  def self.up
    change_table :import_files do |t|
      t.attachment :data
    end
  end

  def self.down
    remove_attachment :import_files, :data
  end
end
