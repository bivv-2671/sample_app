class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                :following, :followers]
  before_action :load_user, only: [:show, :edit, :update, :destroy,
                 :correct_user]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.activated_true.page(params[:page]).per(Settings.page_num)
  end

  def show
    @microposts = @user.microposts.page(params[:page]).per(Settings.page_num)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "email.info"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "home.index.update_s"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "home.index.delete_s"
    else
      flash[:danger] = t "home.index.delete_f"
    end
    redirect_to users_path
  end

  def following
    @title = t "follow.following"
    @user = User.find_by(id: params[:id])
    @users = @user.following.page(params[:page])
    render "show_follow"
  end

  def followers
    @title = t "follow.follower"
    @user = User.find_by(id: params[:id])
    @users = @user.followers.page(params[:page])
    render "show_follow"
  end

  private

  def user_params
    params.require(:user)
          .permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users.show.islogin"
    redirect_to login_url
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "home.nil_user"
    redirect_to root_path
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
