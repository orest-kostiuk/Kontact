class Api::V1::OrderItemsController < ApplicationController
  before_action :find_dish, only: :create
  def index
    order = Order.all
    order = order.where(order_status_id: params[:id])
    render json: order
  end

  def show_order
    current_order
    render json: current_order
  end

  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params.merge(dish_id: @dish.id))
    @order.restaurant_id = @dish.restaurant_id
    @order.user_id = current_user.id
    @order.save
    session[:order_id] = @order.id
    render json: @order
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end
  private

  def find_dish
    @dish = Dish.find(params[:dish_id])
  end
  def order_item_params
    params.permit(:quantity, :dish_id)
  end
end