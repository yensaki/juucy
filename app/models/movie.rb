class Movie < ApplicationRecord
  has_one_attached :file
  has_many_attached :images

  before_save :generate_uuid

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
