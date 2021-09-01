class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user,
                :check_expiration only: [:edit, :update]
  before_action :check_pass_empty, only: [:update]

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "pass-reset.checkmail"
      redirect_to root_url
    else
      flash.now[:danger] = "pass-reset.notmail"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      log_in @user
      @user.update_column(:reset_digest, nil)
      flash[:success] = t "pass-reset.pass_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def valid_user
    return if @user.activated && @user.authenticated?(:reset, params[:id])

    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "pass-reset.expired"
    redirect_to new_password_reset_url
  end

  def load_user
    @user = User.find_by(email: params[:email])
    return if @user

    flash[:danger] = t "users.nil"
    redirect_to root_path
  end

  def check_pass_empty
    return unless params[:user][:password].empty?

    @user.errors.add(:password, t("pass-reset.pass_empty"))
    render :edit
  end
end
