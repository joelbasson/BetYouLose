class WalletsController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :get_wallet
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def show  
  end
  
  def buy
  end
  
  def purchase
    @wallet.credits += params[:credits].to_i
    if @wallet.save
      @wallet.transactions.create!(:description => "Purchased #{params[:credits].to_s} credits.")
      flash[:notice] = "Successfully purchased #{params[:credits].to_s} credits."
      redirect_to root_url
    else
      render :action => 'buy'
    end
  end    
    
  
  private
  
  def get_wallet
    @wallet = current_user.wallet
  end  
end
