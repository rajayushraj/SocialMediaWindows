class CommentsController < ApplicationController

	def new
		@post=Post.find(params[:post_id])
		@comment=Comment.new(post_id:@post)
	end

	def create
		@post=Post.find(params[:post_id])
		@comment=Comment.new(comment_params)
		@comment.user=current_user
		@comment.post=@post
		@post.comments_count=@post.comments_count+1
		if @comment.save && @post.save
			flash[:notice]="Comment Successfully Created"
			redirect_to post_comments_path(@post)
		else
			render 'new'
		end
	end
	def index
		@post=Post.find(params[:post_id])
		@comments=@post.comments.all
	end

	def destroy
		@post=Post.find(params[:post_id])
		@comment=Comment.find(params[:id])
		@comment.destroy
		redirect_to @post
	end

	private
	def comment_params
    params.require(:comment).permit(:content)
  end
end
