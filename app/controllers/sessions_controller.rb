class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    return unless user.try(:authenticate, params[:session][:password])

    if user.activated
      pass_authen user
    else
      flash[:warning] = t "users.notaccount"
      redirect_to root_path
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
