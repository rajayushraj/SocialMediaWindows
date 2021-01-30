class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :fname ,presence: true,length: { minimum: 3,maximum: 25}
  validates :lname ,presence: true,length: { minimum: 3,maximum: 25}
  validates :acc_status,presence: true,:inclusion => { :in => 0..2 }

  has_many :friend_sent , class_name: 'Friendship' ,foreign_key: 'sender_id',inverse_of: 'sender',dependent: :destroy
  has_many :friends, -> {  Friendship.friends },through: :friend_sent,source: :receiver
  has_many :friend_received ,class_name: 'Friendship',foreign_key: 'receiver_id',inverse_of: 'receiver',dependent: :destroy
  has_many :friendsrec, -> { Friendship.friends },through: :friend_received,source: :sender
  has_many :friend_request, -> { Friendship. not_friends },through: :friend_received,source: :sender
  has_many :posts,dependent: :destroy
  has_many :likes,dependent: :destroy
  has_many :comments,dependent: :destroy

  def all_friends
		(friends+friendsrec).uniq
	end

  def full_name
  	"#{fname} #{lname}"
  end
end
