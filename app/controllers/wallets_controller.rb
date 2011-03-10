class WalletsController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :get_wallet
  before_filter :authenticate_user!
  
  def show  
    @transactions = current_user.wallet.transactions.order("created_at DESC").paginate(:per_page => 2, :page => params[:page])
    @bets = current_user.bets.paginate(:per_page => 2, :page => params[:page])
    @wagers = current_user.wagers.paginate(:per_page => 2, :page => params[:page])
  end
  
  def buy
  end
  
  def purchase
    if @wallet.validate_purchase(params[:credits])
      @wallet.credits += params[:credits].to_i
      if @wallet.save
        @wallet.transactions.create!(:description => "Purchased #{params[:credits].to_s} credits.")
        flash[:notice] = "Successfully purchased #{params[:credits].to_s} credits."
        redirect_to root_url
      else
        flash[:notice] = "Value must be a number greater than 50 and less than 500"
        render :action => 'buy'
      end
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
