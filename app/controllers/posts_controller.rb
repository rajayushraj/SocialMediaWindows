class PostsController < ApplicationController
	before_action :authenticate_user!
	def index
		@posts=Post.all
	end
	def new
		@post=Post.new
	end
	def show
		@post=Post.find(params[:id])
	end
	def create
		@post = Post.new(post_params) 
    @post.user = current_user
    if @post.save 
      flash[:notice] = "Post was created successfully." 
      redirect_to @post
    else 
      render 'new' 
    end

	end
	def destroy
		@post=Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private

	def post_params
    params.require(:post).permit(:description)
   end
end