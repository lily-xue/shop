class AppliesController < ApplicationController
  before_action :signed_in_user,only: [:new,:edite,:update,:destroy,:index] 
  before_action :admin_user,only: [:edite,:update,:destroy] 
def new
@apply = Apply.new
remember_token = User.encrypt(cookies[:remember_token])#取出cookies中的remember_token值，加密
@current_user ||= User.find_by(remember_token: remember_token)#根据加密后的remember_token值从数据库中查找用户
end
def index
@applies = Apply.all
end
def create
@apply = current_user.applies.build(apply_params)
@apply.status = "已申请"
remember_token = User.encrypt(cookies[:remember_token])#取出cookies中的remember_token值，加密
@current_user ||= User.find_by(remember_token: remember_token)#根据加密后的remember_token值从数据库中查找用户
if @apply.save
        redirect_to @apply, notice: '申请成功' 
      else
       render action: 'new' 
end
end

def show
@apply = Apply.find(params[:id])
remember_token = User.encrypt(cookies[:remember_token])#取出cookies中的remember_token值，加密
@current_user ||= User.find_by(remember_token: remember_token)#根据加密后的remember_token值从数据库中查找用户
end

def update
end

private 
    def apply_params
      params.require(:apply).permit(:status, :overtime ,:tips,:user_id)
    end
end
