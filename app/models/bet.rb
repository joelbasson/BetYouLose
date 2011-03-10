class Bet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title, :description, :end_date, :wager_amount, :verify_description, :verified, :confirmed, :user_id, :display_name, :wagers_count, :status
  has_many :transactions
  has_many :wagers
  validates_presence_of :title, :description, :end_date, :wager_amount, :verify_description, :display_name
  validates_length_of :title, :minimum => 2
  validates_length_of :title, :maximum => 80
  validates_length_of :display_name, :minimum => 2
  validates_length_of :display_name, :maximum => 20
  validates_length_of :description, :minimum => 20
  validates_length_of :description, :maximum => 500
  validates_length_of :verify_description, :minimum => 20
  validates_length_of :verify_description, :maximum => 500
  scope :standard, :order => "verified ASC", :conditions => ["end_date >= ? AND confirmed = ?", Time.zone.now, true]  
  validate do |bet|
      bet.errors.add(:end_date, "end date must be after now") if bet.end_date < Time.now
      bet.errors.add(:wager_amount, "not enough credits for this wager amount") if (bet.wager_amount && bet.wager_amount > bet.user.wallet.credits)
  end
  
  def total_wagers
    if self.wagers.size < 1
      return 1
    else
      return self.wagers.size
    end    
  end  
  
  def total_value
    if self.wagers.size < 1
      return self.wager_amount
    else
      self.wagers.sum(:credits)  
    end  
  end  
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
  
  def assign_winnings(result)
    if result == "Won" 
      indv_amount = self.wagers.sum(:credits).to_i / self.wagers.bets_for.size 
      for bet in self.wagers.bets_for
        bet.user.wallet.credits += indv_amount
        bet.user.wallet.save
        bet.user.wallet.transactions.create!(:description => "Assigned winnings of #{indv_amount.to_s} credits to user.")
      end
    elsif result == "Lost"
      indv_amount = self.wagers.sum(:credits).to_i /  self.wagers.bets_against.size if result == false
      for bet in self.wagers.bets_against
        bet.user.wallet.credits += indv_amount
        bet.user.wallet.save
        bet.user.wallet.transactions.create!(:description => "Assigned winnings of #{indv_amount.to_s} credits to user.")
      end   
    end
  end  
  
end
