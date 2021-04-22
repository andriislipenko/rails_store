class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    unless params[:query].blank?
      @items = Item.search(params[:query])
      return
    end

    @items = Item.all
  end
end
