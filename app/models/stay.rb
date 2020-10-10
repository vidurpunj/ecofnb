class Stay < ApplicationRecord
	has_many :stay_homes
	extend FriendlyId
	  friendly_id :name, use: [:slugged, :finders]
	  validates :name,:presence => true

	  def should_generate_new_friendly_id?
      slug.blank? || self.stay_name_changed?
    end
end
