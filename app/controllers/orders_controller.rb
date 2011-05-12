class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @order.company_id = current_company.id if !params[:company_id].blank?
    @order.customer_id = params[:customer_id] if !params[:customer_id].blank?
    @order.title_loan_id = params[:title_loan_id] if !params[:title_loan_id].blank?
    @title_loan = TitleLoan.find(params[:title_loan_id]) if !params[:title_loan_id].blank?
    @order.loan_payment = sprintf("%.2f",@title_loan.payment) if !params[:title_loan_id].blank?
  end

  def create
    @order = Order.new(params[:order])
    if @order.save
      flash[:notice] = "Successfully created order."
      redirect_to [current_company, @order]
    else
      render :action => 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      flash[:notice] = "Successfully updated order."
      redirect_to [current_company, @order]
    else
      render :action => 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:notice] = "Successfully destroyed order."
    redirect_to company_orders_url
  end
end
