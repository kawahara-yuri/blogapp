class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @image = user.user_image
    @blogs = user.blogs.page(params[:page]).per(10).order("created_at DESC")
  end
end
