class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    save_order_to_session params[:item_id], params[:quantity].to_i

    redirect_to root_path
  end

  def create
    order_to_save = init_order_to_save

    if order_to_save.save
      empty_session_cart
      redirect_to :root, notice: 'Purchased successfully!'
    else
      flash[:notice] = 'Failed to save order!'
      render 'show_cart'
    end
  end

  def show_cart
    map_orders_from_session
  end

  def clear_cart
    empty_session_cart

    redirect_to root_path, notice: 'Cart is clear'
  end

  def remove_from_cart
    session[:orders].delete_at params[:id].to_i
    map_orders_from_session
    redirect_to :cart
  end

  private

  def save_order_to_session(item_id, quantity)
    session[:orders] ||= []

    unless Item.find(item_id)
      flash[:notice] = 'Item no longer exists. Please reload the page.'
      return
    end

    if quantity > 0
      session[:orders] << { item_id: params[:item_id], quantity: params[:quantity] }
    else
      flash[:notice] = 'Enter positive quantity!'
    end
  end

  def map_orders_from_session
    return unless session[:orders].instance_of? Array

    @total_amount = 0

    @orders = session[:orders].each_with_index.map do |order, i|
      item = Item.find(order['item_id'])
      @total_amount += item.price * order['quantity'].to_i

      { index: i, item_id: item.id, name: item.name, price: item.price, quantity: order['quantity'] }
    end
  end

  def init_order_to_save
    order_to_save = current_user.orders.new
    amount = 0

    order_to_save.order_descriptions = session[:orders].map do |order|
      item = Item.find(order['item_id'])

      amount += item.price * order['quantity'].to_i
      OrderDescription.new(order: order_to_save, item: item, quantity: order['quantity'])
    end

    order_to_save.amount = amount
    order_to_save
  end

  def empty_session_cart
    session[:orders] = []
    @orders = []
  end
end
