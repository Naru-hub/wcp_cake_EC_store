class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
end
