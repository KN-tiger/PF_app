class Room < ApplicationRecord
  
 has_many :entries, dependent: :destroy
 has_many :user_messages, dependent: :destroy
 has_many :admin_messages, dependent: :destroy
  
end
