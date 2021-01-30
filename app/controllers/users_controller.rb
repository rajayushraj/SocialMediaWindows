class UsersController < ApplicationController
	def myfriends
		@friends=current_user.all_friends
	end
	def show
		@user=User.find(params[:id])
		@friendsrequest=@user.friend_request
	end
	def search
		
	end
end
