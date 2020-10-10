class ProfileController < ApplicationController
  before_action :authenticate_user! 


  def guest_profile
  end

end
