class Movie < ApplicationRecord
  has_one_attached :file
end
