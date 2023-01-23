class Post < ApplicationRecord
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
