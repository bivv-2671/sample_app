class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user.try(:authenticate, params[:session][:password])
      pass_authen user
    else
      flash.now[:danger] = t "users.show.notlogin"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  def current_user? user
    user == current_user
  end
end
