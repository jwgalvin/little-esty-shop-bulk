class Merchants::DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
    three_holidays
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

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])

    if @discount.update(promo_params)
        redirect_to "/merchants/#{@discount.merchant.id}/discounts/#{@discount.id}"
        flash[:alert] = "Merchant successfully updated!"
    else
      redirect_to "/merchants/#{@discount.merchant.id}/discounts/#{@discount.id}/edit"
      flash[:alert] = "Error: #{error_message(@discount.errors)}"
    end
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
