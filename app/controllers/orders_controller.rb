class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
    # @purcharser = Purcharser.new
    # @shipping_address = ShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      redirect_to root_path
    else
      render action: :index
    end
    # @purcharser = Purcharser.new(purcharser_params)
    # binding.pry
    # if @purcharser.save
    #   @shipping_address = ShippingAddress.new(shipping_address_params)
    #   if @shipping_address.save
    #     redirect_to root_path
    #   else
    #     render :index
    #   end
    # else
    #   render :index
    # end
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :prefecture_id, :municipality, :address_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

    # def purcharser_params
    #   params.permit(:item_id).merge(user_id: current_user.id)
    # end

    # def shipping_address_params
    #   params.require(:shipping_address).permit(:postal_code, :prefecture_id, :municipality, :address_number, :building_name, :phone_number).merge(purcharser_id: @purcharser.id)
    # end

end
