class Entry < ApplicationRecord
  
 belongs_to :admin  
 belongs_to :user
 belongs_to :room
 
end
