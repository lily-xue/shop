class SessionsController < ApplicationController
def new
end
def create
user = User.find_by(name: params[:session][:email].downcase)
if user && user.authenticate(params[:session][:password])
else 
flash[:error] = "用户名或者密码错误"
render 'new'
end
def destroy
end
end
