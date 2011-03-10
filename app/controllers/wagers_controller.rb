class WagersController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :authenticate_user!
  
  def my_wagers  
    @wagers = current_user.wagers.paginate(:per_page => 2, :page => params[:page])
  end

  def bet_now
    @bet = Bet.find(params[:bet_id])
    unless @bet.wager_amount > current_user.wallet.credits 
      @bet.wagers.create(:credits => @bet.wager_amount, :against => params[:against], :user_id => current_user.id)
      current_user.wallet.credits -= @bet.wager_amount
      current_user.wallet.save
      current_user.wallet.transactions.create!(:description => "Bet #{@bet.wager_amount.to_s} credits.", :bet_id => @bet)
      respond_with(@bet) do |format|
        format.html { redirect_to @bet }
      end  
    else
      redirect_to :back, :notice => "You do not have enough credits to bet on this. Try purchasing more credits"
    end
  end
    
  private
end
