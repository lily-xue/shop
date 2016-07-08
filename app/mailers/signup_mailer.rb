class SignupMailer < ActionMailer::Base
  default from: "yyhinabian@163.com"

def sendmail(user)
@user=user
mail(to: @user.email,subject:'你好，这是来自rails的邮件')
end

end
