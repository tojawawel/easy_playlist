class CreateImportFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :import_files do |t|

      t.timestamps
    end
  end
end
