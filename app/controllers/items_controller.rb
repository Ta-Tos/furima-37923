class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :sold_data, only: [:index, :show, :edit, :update, :destroy]
  before_action :sold_out_move, only: [:edit, :update, :destroy]

  def index
    @items = Item.order(id: 'DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_explain, :category_id, :delivery_charge_id, :item_condition_id,
                                 :shipping_day_id, :prefecture_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless current_user.id == @item.user_id
  end

  def sold_data
    @purcharser = Purcharser.order(item_id: 'DESC')
  end

  def sold_out_move
    redirect_to action: :index if @purcharser.find_by(item_id: @item.id)
  end
end
