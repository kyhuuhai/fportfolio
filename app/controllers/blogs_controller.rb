class BlogsController < ApplicationController
  def index
    @categories = Category.blog
    if params[:category].blank?
      @blogs = Post.blog.order_by_newest.page(params[:page]).per Settings.per_page.blog
    else
      @category = Category.find_by id: params[:category]
      if @category
        @blogs = @category.posts.post_by_category_and_type(params[:category], Post.target_types[:blog])
          .order_by_newest.page(params[:page]).per Settings.per_page.blog
      else
        flash[:danger] = t "record_isnt_exist"
        redirect_to blogs_path
      end
    end
  end

  def show
    @categories = Category.blog
    @blog = Post.find_by id: params[:id]
    if @blog
      @posts_relate = @blog.category.posts.blog.except_id(@blog.id).order_by_newest
    else
      flash[:warning] = t "record_isnt_exist"
      redirect_to root_url
    end
  end
end
