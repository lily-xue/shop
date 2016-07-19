class HomeController < ApplicationController
  def welcome
  end
  def index
remember_token = User.encrypt(cookies[:remember_token])#取出cookies中的remember_token值，加密
@current_user ||= User.find_by(remember_token: remember_token)#根据加密后的remember_token值从数据库中查找用户
  end
  def about
  end

  def contact
  end
end
