class BetsController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_admin, :only => [:edit, :destroy]
  before_filter :find_bet, :except => [:index, :new, :create, :my_bets]
  
  def index
    if !params[:search]
      params["search"] = {"meta_sort" => "wagers_count.desc"}
    end  
    @search = Bet.standard.search(params[:search])
    @bets = @search.paginate(:per_page => 2, :page => params[:page])
  end

  def show
    @wagers = @bet.wagers.order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
  end

  def new
    @bet = Bet.new
    @bet.end_date = 3.days.from_now
    respond_with(@bet)
  end

  def create
    @bet = Bet.new(params[:bet])
    @bet.confirmed = true if current_user.admin?
    @bet.user = current_user
    if @bet.save
      @bet.wagers.create(:credits => @bet.wager_amount, :against => false, :user_id => @bet.user.id)
      @bet.user.wallet.credits -= @bet.wager_amount
      @bet.user.wallet.save
      @bet.user.wallet.transactions.create!(:description => "Created Bet for #{@bet.wager_amount.to_s} credits.", :bet_id => @bet)
      respond_with(@bet, :notice => "Successfully created bet.")
    else
      render :action => 'new'
    end  
  end

  def edit
  end

  def update
    old_status = @bet.status
    @bet.verified = true if params[:bet][:status] != 'Undecided'
    if @bet.update_attributes(params[:bet])
      @bet.assign_winnings(@bet.status) if @bet.status != old_status
      respond_with(@bet, :notice  => "Successfully updated bet.")
    else
      render :action => 'edit'
    end
  end

  def destroy
    @bet.destroy
    respond_with(@bet, :notice => "Successfully destroyed bet.")
  end
  
  def my_bets  
    @bets = current_user.bets.paginate(:per_page => 2, :page => params[:page])
  end
  
  private 
  
  def find_bet
    @bet = Bet.find(params[:id])
  end  
end
