class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, length: {maximum: Settings.content_len}
  validates :image, content_type: {in: %w("image/jpeg image/gif image/png"),
                                   message: :format},
             size: {less_than: Settings.length_image.megabytes,
                    message: :less_than}

  scope :latest, ->{order created_at: :desc}
  scope :with_user, ->(users_id){where "user_id IN (?)", users_id}

  def display_image
    image.variant resize_to_limit: [Settings.image_width, Settings.image_heigth]
  end
end
