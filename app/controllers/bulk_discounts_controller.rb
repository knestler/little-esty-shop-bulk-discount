class BulkDiscountsController < ApplicationController
  # before_action :holidays_information, only: [:index]
  
  # def holidays_information
  # end
  
  def index 
    @holidays = HolidaySearch.new.holiday_information[0..2]
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
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
  
  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.bulk_discounts.find(params[:id]).destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end
  
  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end
  
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
    
    if @discount.update(discount_params)
      redirect_to merchant_bulk_discount_path(@merchant, @discount)
    else  
      redirect_to edit_merchant_bulk_discount_path(@merchant, @discount)
      flash.alert= "Fields can't be left blank"
    end
  end
  
  
  private
  def discount_params
    params.permit(:percentage_discount, :quantity_threshold)
  end
  
end