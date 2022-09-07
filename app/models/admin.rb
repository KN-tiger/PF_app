class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:login_id]
         
  validates :login_id, uniqueness: true, presence: true
  validates :email, uniqueness: true
  
  def email_required?
    false
  end

  def email_changed?
    false
  end
end