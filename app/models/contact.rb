class Contact < ApplicationRecord
	validates :first_name, :last_name, :email,:message,:presence => true
end
