class ItemsController < ApplicationController
  before_action :set_hotel
  before_action :set_item, only: %i[ show edit update destroy ]
  

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.days =[]
    @item.times= []
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @item = @hotel.items.build(item_params)


    respond_to do |format|
      if @item.save
        format.html { redirect_to hotel_item_path(@hotel , @item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to hotel_item_path(@hotel , @item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = @hotel.items.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      days= params[:days] || []
      times= params[:times] || []
      p=params.require(:item).permit( :name)
      p.merge!(days: days,times: times)
      
    end

    def set_hotel
      @hotel= Hotel.find(params[:hotel_id])
    end
end
