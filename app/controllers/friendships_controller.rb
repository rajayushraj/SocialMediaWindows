class FriendshipsController < ApplicationController
	def create
		@rec=User.find(params[:user_id])
		@ff=Friendship.find_by(sender_id:current_user,receiver_id:@rec,status:false)
		if @ff
			flash[:notice]="You have already send friendrequest"
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
		@friendsrequest=current_user.friend_request
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
		if params[:friend].present?
			@friends=User.search(params[:friend])
			@friends=current_user.except_current_user(@friends)
			if @friends.present?
				respond_to do |format|
					format.js { render partial: 'users/result'}
				end
			else
				respond_to do |format|
					flash[:notice]="No user Present"
					format.js { render partial: 'users/result'}
				end
			end
		else
			respond_to do |format|
				flash[:notice]="No user Present"
				format.js { render partial: 'users/result'}
			end
		end
	end

	def destroy
		@send=User.find(params[:user_id])
		@rec=User.find(params[:id])
		@ff=Friendship.find_by(sender_id:@send,receiver_id:@rec,status:true)
		@gg=Friendship.find_by(sender_id:@rec,receiver_id:@send,status:true)
		if @ff
			@ff.destroy
			redirect_to my_friends_path
		else
			@gg.destroy
			redirect_to my_friends_path
		end
	end
end
