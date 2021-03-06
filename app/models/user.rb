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
  has_one_attached :image

  def all_friends
		(friends+friendsrec).uniq
	end

  def full_name
  	"#{fname} #{lname}"
  end

  def self.search(searchstring,reject_id)
  	searchstring.strip!
  	#@first=match('email',searchstring)
  	#@second=match('fname',searchstring)
  	#@third=match('lname',searchstring)
  	#(@first+@second+@third).uniq
  	@allsearchresult=where("email like ?","%#{searchstring}%").or(where("fname like ?","%#{searchstring}%").or(where("lname like ?","%#{searchstring}%")))
  	@allsearchresult=@allsearchresult.where.not(id:reject_id)
  	@allsearchresult
  end

  def self.match(fieldname,searchstring)
  	where("#{fieldname} like ?","%#{searchstring}%")
  end

  def except_current_user(users)
  	users.reject { |user| user.id==self.id }
  end

  def not_friends_with?(id_of_friend)
  	@ff=Friendship.where(receiver_id:self.id,sender_id:id_of_friend,status: true).or(Friendship.where(receiver_id:id_of_friend,sender_id:self.id,status: true))
  	#@gg=Friendship.find_by(receiver_id:id_of_friend,sender_id:self.id,status: true)
  	!@ff.present?
  end
end
