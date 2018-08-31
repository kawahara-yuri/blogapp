class BlogsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @blogs = Blog.includes(:user).order("created_at DESC").page(params[:page]).per(10)
  end

  def new
    @blog = Blog.new
  end

  def create
    Blog.create(text: blog_params[:text], user_id: current_user.id)
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy if blog.user_id == current_user.id
  end

  def update
    blog = Blog.find(params[:id])
    blog.update(blog_params) if blog.user_id == current_user.id
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def show
    @blog = Blog.find(params[:id])
  end

  private
    def blog_params
      params.require(:blog).permit(:text)
    end

    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end

end
