class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
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

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
    end
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new session["devise.user_attributes"] do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end
  
  def password_required?
    super && provider.blank?
  end
  
end
