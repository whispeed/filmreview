class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :movies
  has_many :reviews
  has_many :favorites
  has_many :favorite_movies, :through => :favorites, :source => :movie

  def is_member_of?(movie)
    favorite_movies.include?(movie)
  end

  def join!(movie)
    favorite_movies << movie
  end

  def quit!(movie)
    favorite_movies.delete(movie)
  end

end
