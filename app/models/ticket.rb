class Ticket < ActiveRecord::Base
belongs_to :user
has_one :apply
end
