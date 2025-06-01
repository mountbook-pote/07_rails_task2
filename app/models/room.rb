class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 200 }
  validates :price, presence: true, length: { maximum: 7 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :adress, presence: true, length: { maximum: 100 }

  #アイコン画像用のコード
  has_one_attached :image
  validate :image_content_type
  validate :image_size

  def image_content_type
    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:image, '：ファイル形式が、JPEG, PNG, GIF以外になってます。ファイル形式をご確認ください。')
    end
  end

  def image_size
    if image.attached? && image.blob.byte_size > 1.megabytes
      errors.add(:image, '：1MB以下のファイルをアップロードしてください。')
    end
  end
end
