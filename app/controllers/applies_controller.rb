class AppliesController < ApplicationController
  before_action :signed_in_user,only: [:new,:edite,:update,:destroy,:index]
  before_action :admin_user,only: [:edite,:update,:destroy]
def new
@apply = Apply.new
remember_token = User.encrypt(cookies[:remember_token])#取出cookies中的remember_token值，加密
@current_user ||= User.find_by(remember_token: remember_token)#根据加密后的remember_token值从数据库中查找用户
end
def index
if @current_user.admin == true   #如果当前用户为管理员，则显示所有请假信息
       @applies = Apply.paginate(page: params[:page],per_page: 10)
    else
      @applies = @current_user.applies.paginate(page: params[:page],per_page: 10)  #如果当前用户是普通用户，则显示本人的所有申请信息，根据申请时间降序排序
      @applie = Application.new
    end
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
  apply = Apply.find(params[:id])
  if @current_user.admin? && apply.status == "申请中"#管理员更新状态，可以同事更新备注和状态
    apply.update(apply_params_status)
  end
  redirect_to applications_path
end

private
    def apply_params
      params.require(:apply).permit(:status, :overtime ,:tips,:user_id)
    end

    def apply_params_status
      params.require(:apply).permit(:status,:tips)
    end

    def admin_user#如果不是管理员，则跳转到根页面
       @current_user = User.find_by(id: session[:user_id])
       redirect_to(root_path) unless @current_user.admin?
     end




end
