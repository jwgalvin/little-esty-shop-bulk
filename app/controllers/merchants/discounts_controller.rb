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
      flash[:alert] = "Error: #{error_message(@discount.errors)}"
    end
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def destroy
    @discount = Discount.find(params[:id])
    merch_id = @discount.merchant_id
    @discount.destroy
    redirect_to "/merchants/#{merch_id}/discounts"
  end

private
  def promo_params
    params.permit(:name, :threshold, :percent)
  end
end
