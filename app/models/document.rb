class Document < ApplicationRecord
  belongs_to :user

  attachment :doc_image
end
