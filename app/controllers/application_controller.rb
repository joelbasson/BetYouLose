class ApplicationController < ActionController::Base
  protect_from_forgery
  
    def after_sign_in_path_for(resource)
      case resource
        when :user, User 
          if current_user.wallet.nil?
            current_user.wallet = Wallet.create!(:credits => 0)
            current_user.save
          end
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
