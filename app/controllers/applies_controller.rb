
class AppliesController < ApplicationController
def new
@apply = Apply.new
remember_token = User.encrypt(cookies[:remember_token])#取出cookies中的remember_token值，加密
@current_user ||= User.find_by(remember_token: remember_token)#根据加密后的remember_token值从数据库中查找用户
end
def index
@applies = Apply.all
end
def create
@apply = Apply.new(apply_params)
remember_token = User.encrypt(cookies[:remember_token])#取出cookies中的remember_token值，加密
@current_user ||= User.find_by(remember_token: remember_token)#根据加密后的remember_token值从数据库中查找用户
if @apply.save
redirect_to @apply
else
render "new"
end
end

def update
end

private 
    def apply_params
      params.require(:apply).permit(:status, :overtime ,:tips)
    end
end
