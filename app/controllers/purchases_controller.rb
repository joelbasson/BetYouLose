class PurchasesController < ApplicationController
  respond_to :html, :xml, :json, :js
  before_filter :find_purchase, :only => [:show, :destroy]
  before_filter :authenticate_admin
  
  def index
    if !params[:search]
      params["search"] = {"meta_sort" => "id.desc"}
    end
    @search = Purchase.search(params[:search])
    @purchases = @search.paginate(:per_page => 2, :page => params[:page])
  end

  def show
  end

  def destroy
    @purchase.destroy
    redirect_to purchases_url, :notice => "Successfully destroyed purchase."
  end
  
  def payment_info
    purchase = Purchase.find(params[:purchase_id])
    @payment_notification = purchase.payment_notification
  end  
  
  private
  
  def find_purchase
    @purchase = Purchase.find(params[:id])
  end  
end
