class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many  :user_associations, :dependent => :destroy
  has_many  :breeders, :through => :user_associations
 
  def multiple_associations?
    self.user_associations.count > 1
  end  
  
  def associations
    self.breeders
  end
  
  def set_association(association_id)
    UserAssociation.find(association_id).breeder_id
  end
  
end
