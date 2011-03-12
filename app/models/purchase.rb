class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :wallet
  has_one :payment_notification
  validates_presence_of :amount
  validates_numericality_of :amount, :only_integer => true, :message => "can only be a whole number."
  validates_inclusion_of :amount, :in => 50..500, :message => "can only be between 50 and 500."
  validate do |purchase|
      purchase.errors.add(:amount, "must be in multiples of 50") if purchase.amount && (purchase.amount / 50) % 1 != 0
  end
  
  def assign_credit_value
    self.value = self.amount * APP_CONFIG["credit_value"].to_d
  end  
  
  def currency
    APP_CONFIG["default_currency_code"]
  end  
  
  def status
    self.purchased_at ? "completed" : "waiting"
  end  
  
  def paypal_url(return_url, notify_url)
    values = {
      :business => 'test_1299876308_biz@betyoulose.com',
      :cmd => '_xclick',
      :upload => 1,
      :return => return_url,
      :invoice => id,
      :notify_url => notify_url,
      :amount => self.value,
      :item_name => self.amount.to_s + " credits",     
      :currency_code => currency
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
  
end
