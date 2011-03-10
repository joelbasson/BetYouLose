class Wager < ActiveRecord::Base
  belongs_to :bet, :counter_cache => true
  belongs_to :user
  scope :bets_for, :conditions => ["against = ?", false]  
  scope :bets_against, :conditions => ["against = ?", true]  
  
  def in_words
    if against
      "Bet that this bet is a Fail!"
    else
      "Bets that this bet is right!"
    end   
  end 
   
end
