class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :wallet
  has_one :payment_notification
  
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
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
  
end
