class LikesController < ApplicationController
	def create
		@post=Post.find(params[:post_id])
		@likee=Like.find_by(post_id:@post,user_id:current_user)
		if @likee
			flash[:notice]="You  have already liked this post"
			redirect_to post_path(@post) and return
		end
		@like=Like.new
		@like.post=@post
		@like.user=current_user
		if @like.save
			flash[:notice]="You liked this post"
			redirect_to post_path(@post)
		else
			redirect_to root_path
		end
	end
end
