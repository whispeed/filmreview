class ReviewsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :find_review_and_check_permission, only: [:edit, :update, :destroy]

  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
  end

  def edit
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = Review.new(review_params)
    @review.movie = @movie
    @review.user = current_user

    if @review.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  def update
    @review.user = current_user

    if @review.update(review_params)
      redirect_to account_reviews_path, notice: "成功修改评论！"
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to account_reviews_path, alert: "评论已删除！"
  end

  private

  def find_review_and_check_permission
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.movie = @movie
    if !current_user.is_member_of?(@movie)
      redirect_to root_path, alert: "必须先收藏才能操作评论！不要耍小聪明哦！"
    end
  end

  def review_params
    params.require(:review).permit(:content)
  end

end
