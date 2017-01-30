class AddDocImageToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :doc_image_id, :string
  end
end
