class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:login_id]

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :favorites, dependent: :destroy

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
  
  def self.search(word)
    if word != ""
      User.where(['last_name LIKE ? OR first_name LIKE ?', "%#{word}%", "%#{word}%"])
      #部分一致で検索
    else
      User.all
    end    
  end

  def self.guest
    User.find_by(login_id: 'guest@example')
  end

end