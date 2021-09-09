class HomeController < ApplicationController
  def index
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.page(params[:page]).per(Settings.page_num)
  end

  def about; end
end
