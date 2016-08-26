class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_activate
    user = User.find_by_name(params[:name])
    if (user != nil && user.IsActived == "f" && user.ActiveCode ==params[:ActiveCode] )then
     user.update_attribute(:IsActived, true)
     flash[:notice] = "激活成功"
   elsif user != nil and user.IsActived == "t" then
     flash[:notice] = "你已经激活过了~"
   else
     flash[:notice] = "激活失败"
   end
 end
end
