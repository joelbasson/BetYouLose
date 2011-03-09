class WagersController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :authenticate_user!

  def bet_now
    @bet = Bet.find(params[:bet_id])
    unless @bet.wager_amount > current_user.wallet.credits 
      if @bet.wagers.size < 1
        @bet.wagers.create(:credits => @bet.wager_amount, :against => false, :user_id => @bet.user.id)
      end  
      @bet.wagers.create(:credits => @bet.wager_amount, :against => params[:against], :user_id => current_user.id)
      current_user.wallet.credits -= @bet.wager_amount
      current_user.wallet.save
      current_user.wallet.transactions.create!(:description => "Bet #{@bet.wager_amount.to_s} credits.", :bet_id => @bet)
      redirect_to @bet
    else
      redirect_to :back, :notice => "You do not have enough credits to bet on this. Try purchasing more credits"
    end
  end
    
  private
end