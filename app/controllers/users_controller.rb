class UsersController < ApplicationController

  def index
    @users = User.order_by_newest.page(params[:page]).per Settings.per_page.user
  end

  def show
    @user = User.find_by id: params[:id]
    @certificate_users = @user.certificate_users
    @techniques = @user.techniques
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "profile.created"
      redirect_to root_url
    else
      flash[:error] = t "profile.create_fail"
      render new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :user_name, :email, :password,
      :password_confirmation
  end
end
