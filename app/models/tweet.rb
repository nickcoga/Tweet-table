class Tweet < ApplicationRecord
  belongs_to :user

  has_many :replies, class_name: 'Tweet', foreign_key: 'replied_to_id',
                     dependent: :destroy, inverse_of: false
  belongs_to :replied_to, class_name: 'Tweet', optional: true, counter_cache: :replies_count

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates :body, presence: true
  validates :body, length: { maximum: 140, message: 'Cannot be more than 140 characters' }

  # validates :likes_count, numericality: { only_integer: true } # Para descomentar
end
