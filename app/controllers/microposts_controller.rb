class MicropostsController < ApplicationController
  before_action :correct_user, only: :destroy
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :micropost_image, only: :create

  def create
    if @micropost.save
      flash[:success] = t "micropost.create_s"
      redirect_to root_path
    else
      @feed_items = current_user.feed.page(params[:page]).per(Settings.page_num)
      render "home/index"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "micropost.delete_s"
    else
      flash[:danger] = t "micropost.delete_f"
    end

    redirect_to request.referer || root_path
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :image
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t "micropost.invalid"

    redirect_to request.referer || root_path
  end

  def micropost_image
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach params[:micropost][:image]
  end
end
