module SessionsHelper
def sign_in(user)#用户登录
remember_token = User.new_remember_token  #调用User模型中的函数生成随机的remember_token值
cookies.permanent[:remember_token] = remember_token#把token值存入cookies中，默认设置有效期为20年
user.update_attribute(:remember_token,User.encrypt(remember_token))#将加密的token值存入数据库中
self.current_user = user#设置用户为当前登录用户设置@current_user的值
end

def sign_in?
!current_user.nil?  #current_user的值不为空，则说明有用户登录
end

def current_user=(user)
@current_user = user
end
 
def current_user #获取当前登录用户，用于网页跳转
remember_token = User.encrypt(cookies[:remember_token])#取出cookies中的remember_token值，加密
@current_user ||= User.find_by(remember_token: remember_token)#根据加密后的remember_token值从数据库中查找用户
end

def current_user?(user)
user == current_user
end

end
