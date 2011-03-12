class WalletsController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :get_wallet
  before_filter :authenticate_user!
  
  def show  
    @transactions = current_user.wallet.transactions.order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
  end
  
  def buy
  end
  
  def purchase
    if @wallet.validate_purchase(params[:credits])
      @purchase = Purchase.new
      @purchase.amount = params[:credits].to_i
      @purchase.value = @purchase.amount * 2
      @purchase.user = current_user
      @purchase.wallet = current_user.wallet
      if @purchase.save
        @wallet.transactions.create!(:description => "Attempted to purchase #{params[:credits].to_s} credits.")
        redirect_to @purchase.paypal_url(payment_notifications_url,payment_notifications_url)
      end  
      # @wallet.credits += params[:credits].to_i
      #      if @wallet.save
      #        @wallet.transactions.create!(:description => "Purchased #{params[:credits].to_s} credits.")
      #        flash[:notice] = "Successfully purchased #{params[:credits].to_s} credits."
      #        redirect_to root_url
      #      else
      #        flash[:notice] = "Value must be a number greater than 50 and less than 500"
      #        render :action => 'buy'
      #      end
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
