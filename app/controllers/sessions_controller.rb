class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user.try(:authenticate, params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_to root_path
    else
      flash.now[:danger] = t "users.show.notlogin"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
