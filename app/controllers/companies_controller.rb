class CompaniesController < ApplicationController
  
  before_filter :authenticate_user!
  load_and_authorize_resource 
  
  def index
    @companies = Company.all
  end

  def show
    if !params[:company_id].blank?
      @company = Company.find(params[:company_id])
    else
      @company = Company.find(params[:id])
    end
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      flash[:notice] = "Successfully created company."
      redirect_to @company
    else
      render :action => 'new'
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "Successfully updated company."
      redirect_to company_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:notice] = "Successfully destroyed company."
    redirect_to companies_url
  end
  
  def dashboard
    @tasks = Task.where("company_id = ? OR assigned_to = ?", current_company, current_user)
  end
  
end
