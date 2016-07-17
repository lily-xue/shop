class SessionsController < ApplicationController
def new
end

def create
user = User.find_by(name: params[:session][:name].downcase)  #根据用户名查找用户
if user && user.authenticate(params[:session][:password])  #如果用户名存在且密码验证正确，则登录该用户，跳转到该用户页面
sign_in user
redirect_to user
else 
flash[:error] = "用户名或者密码错误"
render 'new'
end
end

def destroy
end

end
