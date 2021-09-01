class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by(id: params[:followed_id])
    if @user
      current_user.follow(@user)
      format_form
    else
      flash[:danger] = t "home.nil_user"
      redirect_to root_path
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow(@user)
    format_form
  end

  private

  def format_form
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
