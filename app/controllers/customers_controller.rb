class CustomersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @search = current_company.customers.search(params[:search])
    @customers = @search.all.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
    @customer.title_loans.build
    @customer.company_id = current_company.id
    @customer.user_id = current_user.id
    phone = @customer.phones.build
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      flash[:notice] = "Successfully created customer."
      redirect_to [current_company, @customer]
    else
      render :action => 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Successfully updated customer."
      redirect_to [current_company, @customer]
    else
      render :action => 'edit'
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    flash[:notice] = "Successfully destroyed customer."
    redirect_to company_customers_url
  end
end
