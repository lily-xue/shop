class User < ActiveRecord::Base
before_save {self.email = email.downcase}
before_create :create_remember_token #生成记忆权标，用于记录登录状态

def User.new_remember_token
SecureRandom.urlsafe_base64
end

def User.enrypt(token)#加密记忆权标
Digest::SHA1.hexdigest(token.to_s)
end

private
def create_remember_token
self.remember_token = User.encrypt(User.new_remember_token)
end

end
