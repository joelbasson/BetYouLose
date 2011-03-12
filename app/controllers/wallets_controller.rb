class WalletsController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :get_wallet
  before_filter :authenticate_user!
  
  def show  
    @transactions = current_user.wallet.transactions.order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
  end
  
  def buy
    @purchase = Purchase.new(:amount => 50)
  end
  
  def purchase
      @purchase = Purchase.new(params[:purchase])
      @purchase.value = @purchase.amount * 2 if @purchase.amount
      @purchase.user = current_user
      @purchase.wallet = current_user.wallet
      if @purchase.save
        @wallet.transactions.create!(:description => "Attempted to purchase #{@purchase.amount.to_s} credits.")
        redirect_to @purchase.paypal_url(payment_notifications_url,payment_notifications_url)  
      else
        flash[:notice] = "Value must be a number greater than 50 and less than 500"
        render :action => 'buy'
    end
  end    
    
  
  private
  
  def get_wallet
    @wallet = current_user.wallet
  end  
  
end
