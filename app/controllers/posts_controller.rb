class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    if current_user
      @post = Post.new
    else
      flash[:error] = "Please login or signup to write a post."
      redirect_to login_path
    end
  end

  def create
    if current_user
      @post = current_user.posts.new(post_params)
      if @post.save
        flash[:notice] = "Successfully created a post."
        redirect_to post_path(@post)
      else
        flash[:errors] = @post.errors.full_messages.join(", ")
        # prevent clearing the form when validation failed
        render action: :new
      end
    else
      redirect_to login_path
    end
  end

  def show
  end

  def edit
    unless current_user == @post.user
      flash[:error] = "You can't edit other user's post."
      redirect_to post_path(@post)
    end
  end

  def update
    if current_user == @post.user
      if @post.update_attributes(post_params)
        flash[:notice] = "Successfully edited a post."
        redirect_to post_path(@post)
      else
        flash[:error] = "You can't edit other user's post."
        redirect_to edit_post_path(@post)
      end
    else 
      redirect_to post_path(@post)
    end
  end

  def destroy
    if current_user == @post.user
      @post.destroy
      flash[:notice] = "Successfully delete the post."
      redirect_to user_path(current_user)
    else
      redirect_to post_path(@post)
    end
  end

private 

  def post_params
    params.require(:post).permit(:title, :description)
  end 

  def find_post
    @post = Post.find(params[:id])
  end

end
