class WelcomeController < ApplicationController
  def index
    flash[:notice] = "您已进入电影影评网站！"
  end
end
