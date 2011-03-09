class BetsController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_admin, :only => [:edit, :destroy]
  before_filter :find_bet, :except => [:index, :new, :create]
  
  def index
    respond_with(@bets = Bet.paginate(:per_page => 5, :page => params[:page]))
  end

  def show
  end

  def new
    respond_with(@bet = Bet.new)
  end

  def create
    @bet = Bet.new(params[:bet])
    unless @bet.wager_amount > current_user.wallet.credits  
      @bet.user = current_user
      if @bet.save
        respond_with(@bet, :notice => "Successfully created bet.")
      else
        render :action => 'new'
      end
    else
      render :action => 'new', :notice => "You do not have enough credits to create a bet that size"
    end  
  end

  def edit
  end

  def update
    if @bet.update_attributes(params[:bet])
      respond_with(@bet, :notice  => "Successfully updated bet.")
    else
      render :action => 'edit'
    end
  end

  def destroy
    @bet.destroy
    respond_with(@bet, :notice => "Successfully destroyed bet.")
  end
  
  private 
  
  def find_bet
    @bet = Bet.find(params[:id])
  end  
end
