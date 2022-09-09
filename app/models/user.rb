class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:login_id]
  
  validates :login_id, uniqueness: true, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/ }

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def full_name
    last_name + " " + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end
  
  def self.guest
    find_or_create_by!(login_id: 'guest@example') do |user|
      user.encrypted_password = SecureRandom.urlsafe_base64
      user.last_name = "ゲストさん"
      user.first_name = "ようこそ"
      user.last_name_kana = "ゲストサン"
      user.first_name_kana = "ヨウコソ"
      user.telephone_number = "1234567890"
    end
  end

end