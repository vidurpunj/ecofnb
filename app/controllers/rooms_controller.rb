class RoomsController < InheritedResources::Base
  before_action :find_stay_id, only: [:edit, :update, :destroy]
   layout 'dashboard'

    def index
      @rooms = current_merchant.stay_homes.where(id: StayHome.find(params[:stay_home_id])).last.rooms
    end

	def new
    # byebug
    @room_categories = StayHome.find_by(id: params[:stay_home_id]).room_categories
		@room = Room.new
	end

  def edit
    @room = Room.find(params[:id])
    @room_categories = RoomCategory.all
  end

  def create
   @room = Room.new(room_params)
    @stay = StayHome.find(params[:room][:stay_home_id]).id if params[:room][:stay_home_id].present?
     @room.stay_home_id = @stay
      respond_to do |format|
      if @room.save
        format.html { redirect_to rooms_url}
        flash[:success] = 'home stay room was successfully created.'
        format.json { render :show, status: :created, location:  @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to rooms_url(stay_home_id: @room.stay_home_id), notice: 'home stay room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end



  private

    def room_params
      params.require(:room).permit(:name, :stay_home_id, :room_category_id)
    end

    def find_stay_id
      @room = Room.find(params[:id])
    end
end
