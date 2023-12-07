class Post < ApplicationRecord
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :location, presence: true, length: { maximum: 15 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :text, presence: true, length: { maximum: 195 }
  validates :post_images_images, presence: true
  before_save :validate_latitude_and_longitude

  def validate_latitude_and_longitude
    if new_record? || address_changed?
      success = geocode
      unless success && latitude.present? && longitude.present?
        errors.add(:base, 'この住所からは緯度と経度が取得できないため保存できません。')
        throw(:abort)
      end
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
