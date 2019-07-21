class Audio < ApplicationRecord
  belongs_to :movie

  has_one_attached :file
end
