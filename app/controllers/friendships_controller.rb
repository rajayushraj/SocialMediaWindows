class FriendshipsController < ApplicationController
	def create
		@rec=User.find(params[:user_id])
		@ff=Friendship.find_by(sender_id:current_user,receiver_id:@rec,status:false)
		if @ff
			redirect_to root_path
		else
			@friendrequest=Friendship.new
			@friendrequest.receiver=@rec
			@friendrequest.sender=current_user
			if @friendrequest.save
				flash[:notice]="Friend request send succesfully"
				redirect_to root_path
			else
				flash[:notice]="Friend request does not send"
				redirect_to root_path
			end
		end
	end

	def friendrequest
	end

	def accept
		@send=User.find(params[:id])
		@ff=Friendship.find_by(sender_id:@send,receiver_id:current_user,status:false)
		@ff.status=true
		if @ff.save
			flash[:notice]="Successfully Added Friend"
			redirect_to my_friends_path
		else
			flash[:notice]="Not Addded"
			redirect_to my_friends_path
		end
	end
	def search
		@user=User.find_by(fname:params[:friend])
		render 'users/search'
	end

	def destroy
		@send=User.find(params[:user_id])
		@rec=User.find(params[:id])
		@ff=Friendship.find_by(sender_id:@send,receiver_id:@rec,status:false)
		@ff.destroy
		redirect_to @rec
	end
end
