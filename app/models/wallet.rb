class Wallet < ActiveRecord::Base
  attr_accessible :credits, :user_id
  has_one :user
  has_many :transactions
  validates_numericality_of :credits
    
end
