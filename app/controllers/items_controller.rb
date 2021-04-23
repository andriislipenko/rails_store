class ItemsController < ApplicationController
  include AdminCheck

  before_action :authenticate_user!, except: [:index]
  before_action :admin?, except: [:index]

  def index
    unless params[:query].blank?
      @items = Item.search_by_name(params[:query])
      return
    end

    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)

    if @item.save
      redirect_to root_path, notice: 'Saved!'
    else
      render new_item_path(@item)
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update item_params
      redirect_to root_path, notice: 'Updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    flash[:notice] = @item.destroy ? 'Deleted!' : 'Failed to delete item!'

    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end
