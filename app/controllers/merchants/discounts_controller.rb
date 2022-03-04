class Merchants::DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
  end

  def create
    #binding.pry
    @merchant = Merchant.find(params[:id])
    @discount = @merchant.discounts.create(promo_params)

    if @discount.save
      redirect_to "/merchants/#{@merchant.id}/discounts"
    else
      redirect_to "/merchants/#{@merchant.id}/discounts"
      flash[:alert] = "Error: fill all in and no symbols"
    end
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  private
  def promo_params
    params.permit(:name, :threshold, :percent)
  end
end
