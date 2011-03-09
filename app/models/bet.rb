class Bet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title, :description, :end_date, :wager_amount, :verify_description, :verified, :confirmed, :user_id, :display_name
  has_many :transactions
  has_many :wagers
end
