class OrderedGoodsController < ApplicationController
  before_action :set_ordered_good, only: [:show, :edit, :update, :destroy]

  # GET /ordered_goods
  # GET /ordered_goods.json
  def index
    @ordered_goods = OrderedGood.all
  end

  # GET /ordered_goods/1
  # GET /ordered_goods/1.json
  def show
  end

  # GET /ordered_goods/new
  def new
    @ordered_good = OrderedGood.new
  end

  # GET /ordered_goods/1/edit
  def edit
  end

  # POST /ordered_goods
  # POST /ordered_goods.json
  def create
    @ordered_good = OrderedGood.new(ordered_good_params)

    respond_to do |format|
      if @ordered_good.save
        format.html { redirect_to @ordered_good, notice: 'Ordered good was successfully created.' }
        format.json { render :show, status: :created, location: @ordered_good }
      else
        format.html { render :new }
        format.json { render json: @ordered_good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ordered_goods/1
  # PATCH/PUT /ordered_goods/1.json
  def update
    respond_to do |format|
      if @ordered_good.update(ordered_good_params)
        format.html { redirect_to @ordered_good, notice: 'Ordered good was successfully updated.' }
        format.json { render :show, status: :ok, location: @ordered_good }
      else
        format.html { render :edit }
        format.json { render json: @ordered_good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordered_goods/1
  # DELETE /ordered_goods/1.json
  def destroy
    @ordered_good.destroy
    respond_to do |format|
      format.html { redirect_to ordered_goods_url, notice: 'Ordered good was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ordered_good
      @ordered_good = OrderedGood.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ordered_good_params
      params.require(:ordered_good).permit(:order_id, :good_id, :name, :quantity, :subtotal_in_cents, :fulfilled_at, :canceled_at)
    end
end
