class Apply < ActiveRecord::Base
belongs_to :user
belongs_to :ticket
validates :status, presence: true, inclusion: { in: ["已申请","同意","拒绝"], message: "%{value}不合法" }
end
