class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_topPage, only: [:index]
  before_action :sold_out_move, only: [:index, :create]

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_topPage
    redirect_to root_path if current_user.id == @item.user_id
  end

  def sold_out_move
    @purcharser = Purcharser.order(item_id: 'DESC')
    redirect_to root_path if @purcharser.find_by(item_id: @item.id)
  end

  def order_params
    params.require(:order).permit(:postal_code, :prefecture_id, :municipality, :address_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
