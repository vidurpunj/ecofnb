class Facility < ApplicationRecord
	has_many :stayhome_facilities
    has_many :stay_homes, through: :stayhome_facilities
    belongs_to :facility_type
    has_one :facility_icon


    def feature_icon
    	if self.facility_icon_id.present?
    		return FacilityIcon.find(self.facility_icon_id).icon
    	else
    		return "fa fa-check"
    	end
    end
end
