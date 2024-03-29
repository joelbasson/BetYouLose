class TransactionsController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :authenticate_user!

  def index
    @transactions = current_user.wallet.transactions.paginate(:per_page => 2, :page => params[:page])
    respond_with(@transactions) do |format|
      format.html { redirect_to current_user.wallet }
    end  
  end

end
