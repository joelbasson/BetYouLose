class Wallet < ActiveRecord::Base
  attr_accessible :credits, :user_id
  has_one :user
  has_many :transactions
  validates_numericality_of :credits
  
  def validate_purchase(credits)
    if credits.to_i != 0 && credits.to_i > 49 && credits.to_i < 501 && credits.to_i % 1 == 0
      return true
    end
    return false  
  end
    
end
