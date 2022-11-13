class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: true #空の場合はDBに保存しないというバリデーションを設定
end
