class Image < ApplicationRecord
  belongs_to :movie

  has_one_attached :file
end
