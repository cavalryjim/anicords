# == Schema Information
#
# Table name: beta_comments
#
#  id           :integer          not null, primary key
#  comment      :text
#  page_url     :string(255)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  name         :string(255)
#  email        :string(255)
#  mailing_list :boolean          default(TRUE)
#

class BetaComment < ActiveRecord::Base
  belongs_to :user
  
  #validates_presence_of :comment
  validate :comment_or_mailing_list
  
  after_save :email_comment
  
  def email_comment
    UserMailer.email_comment(self).deliver 
  end
  
  private
  
  def comment_or_mailing_list
    if (comment.blank? && (email.blank? || !mailing_list))
      errors.add(:base, "Need to leave a comment or join our mailing list.")
    end
  end
  
end
