class Wager < ActiveRecord::Base
  belongs_to :bet
  belongs_to :user
  named_scope :bets_for, :conditions => ["against == ?", false]  
  named_scope :bets_against, :conditions => ["against == ?", true]  
end
