class BulkDiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show

  end
  
  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.new(discount_params)

    if @discount.save
        redirect_to merchant_bulk_discounts_path(@merchant)
    else  
      redirect_to new_merchant_bulk_discount_path(@merchant)
      flash.alert= "Fields can't be left blank"
    end

  end

  private
    def discount_params
      params.permit(:percentage_discount, :quantity_threshold)
    end

end