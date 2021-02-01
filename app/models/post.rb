class Post < ApplicationRecord
	enum status: { Public: 0, Private:1,Friend:2 }
	belongs_to :user
	has_many :likes,dependent: :destroy
	has_many :comments,dependent: :destroy
end
