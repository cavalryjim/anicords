class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many  :user_associations, :dependent => :destroy
  has_many  :breeders, :through => :user_associations
         
  def multiple_associations?
    true
  end  
  
end
