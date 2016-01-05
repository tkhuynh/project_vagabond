class UsersController < ApplicationController
  
  before_action :find_user, except: [:index, :new, :create]
  before_action :authorize, except: [:show, :new, :create]

  def index
    @users = User.all
  end

  def new
    #dont let logged in user see signup page
    if current_user
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    #dont let logged in user create new acc
    if current_user
      redirect_to user_path(current_user)
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Successfully signed up."
        redirect_to root_path
      else
        flash[:error] = @user.errors.full_messages.join(', ')
        redirect_to new_user_path
      end
    end
  end

  def show
  end

  def edit
    #dont let current logged in user see edit user profile
    unless current_user == @user
      redirect_to user_path(current_user)
    end
  end

  def update
    #dont let current logged in user edit other user profile
    if current_user == @user
      if @user.update_attributes(user_params)
        flash[:notice] = 'Successfully edited your profile.'
        redirect_to user_path(@user)
      else 
        flash[:error] = @user.errors.full_messages.join(', ')
        redirect_to edit_user_path(@user)
      end
    else
      redirect_to user_path(current_user)
    end
  end

  def destroy
    # only current logged in user can delete his own acc
    if current_user == @user
      @user.destroy
      session[:user_id] = nil
      flash[:notice] = "Successfully deleted profile."
      redirect_to root_path
    else 
      redirect_to user_path(current_user)
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def find_user
    @user = User.find_by_id(params[:id])
  end

end
