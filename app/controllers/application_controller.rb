class ApplicationController < ActionController::Base
  protect_from_forgery
  
    def after_sign_in_path_for(resource)
      if resource.is_a?(User) && resource.wallet.nil?
        resource.wallet = Wallet.create!(:credits => 0)
        resource.save
        super
      else
        super
      end
    end
    
    private
    
    def authenticate_admin
      unless current_user.admin?
        redirect_to :back, :notice => "You are not authorized for that"
      end  
    end  
end
