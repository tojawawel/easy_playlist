class ImportFile < ApplicationRecord
  has_attached_file :data
  validates_attachment_content_type :data, content_type: "text/plain"
end
