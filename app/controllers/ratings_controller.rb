class RatingsController < ApplicationController
  before_action :set_item

  # GET /ratings/new
  def new
    @rating = Ratings.new
  end

 
  # POST /ratings or /ratings.json
  def create
    @rating = @item.ratings.build(rating_params)
    @rating.user = current_user
    @rating.hotel = @hotel
  
    respond_to do |format|
      if @rating.save
        format.html { redirect_to hotel_item_path(@hotel, @item), notice: 'Rating was successfully created.' }
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end
  
  

  # PATCH/PUT /ratings/1 or /ratings/1.json
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @hotel= Hotel.find(params[:hotel_id])
      @item = @hotel.items.find(params[:item_id])
    end

    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(:hotel_id, :item_id, :value, :user_id)
    end
end
