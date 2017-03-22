class MoviesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])

    if current_user != @movie.user
      redirect_to root_path, alert: "你无权这么做！不要耍小聪明！"
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if current_user != @movie.user
      redirect_to root_path, alert: "你无权这么做！不要耍小聪明！"
    end

    if @movie.update(movie_params)
      redirect_to movies_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])

    if current_user != @movie.user
      redirect_to root_path, alert: "你无权这么做！不要耍小聪明！"
    end

    @movie.destroy
    redirect_to movies_path, alert: "已删除影评"
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description)
  end
end
