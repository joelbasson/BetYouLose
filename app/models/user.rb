class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :rpx_connectable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :display_name
  belongs_to :wallet
  has_many :wagers
  has_many :bets
  
  def before_rpx_auto_create(rpx_user)   
    self.display_name = rpx_user["displayName"]
  end
    
end
