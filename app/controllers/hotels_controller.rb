class HotelsController < ApplicationController
  before_action :set_hotel, except: %i[ search index new create] 

  # GET /hotels or /hotels.json
  def index
    @hotels = Hotel.all
  end

  # GET /hotels/1 or /hotels/1.json
  def show
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
  end

  # GET /hotels/1/edit
  def edit
  end

  # def search
  #   if params.dig(:days).present?
  #     @items = Item.includes(:hotel).where("days LIKE (?)", "%#{params[:days]}%")
      
  #   else
  #     today = Date.today.strftime("%A")
  #     @items= Item.includes(:hotel).where("days LIKE ?" , "%#{today}%")
  #   end
  #   render :search

  # end

  def search
    if params.dig(:days).present?
      conditions=[]
      patterns=[]
      params[:days].each do |day|
        conditions << "days LIKE ?"
        patterns << "%#{day}%"
      end
      c = conditions.join(" OR ")
      if params.dig(:times).present?
        c << " AND times LIKE ?"
        patterns << "%#{params[:times].join('%')}%"
      end
      @items = Item.includes(:hotel)
                   .where(c, *patterns)
                   .order(Arel.sql("average_rating DESC, (SELECT COUNT(*) FROM ratings WHERE ratings.item_id = items.id) DESC"))
    else
      today = Date.today.strftime("%A")
      @items = Item.includes(:hotel)
                   .where("days LIKE ?", "%#{today}%")
                   .order(Arel.sql("average_rating DESC, (SELECT COUNT(*) FROM ratings WHERE ratings.item_id = items.id) DESC"))
                   #items.id is the id column in the items table
    end
    render :search
  end
  

   

  
  

  # POST /hotels or /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.days= params[:days] || []
    @hotel.times = params[:times] || []

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to hotel_url(@hotel), notice: "Hotel was successfully created." }
        format.json { render :show, status: :created, location: @hotel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotels/1 or /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to hotel_url(@hotel), notice: "Hotel was successfully updated." }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1 or /hotels/1.json
  def destroy
    @hotel.destroy

    respond_to do |format|
      format.html { redirect_to hotels_url, notice: "Hotel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hotel_params
      params.require(:hotel).permit(:name, :location, :contact_no)
    end
end
