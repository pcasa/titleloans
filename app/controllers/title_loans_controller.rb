class TitleLoansController < ApplicationController
  def index
    @title_loans = TitleLoan.all
  end

  def show
    @title_loan = TitleLoan.find(params[:id])
  end

  def new
    @title_loan = TitleLoan.new
    @title_loan.customer_id = params[:customer_id] if !params[:customer_id].blank?
    @title_loan.parent_id = params[:parent_id] if !params[:parent_id].blank?
    @title_loan.previous_balance = @title_loan.parent.loan_amount if !params[:parent_id].blank?
  end

  def create
    @title_loan = TitleLoan.new(params[:title_loan])
    if @title_loan.save
      flash[:notice] = "Successfully created title loan."
      redirect_to @title_loan
    else
      render :action => 'new'
    end
  end

  def edit
    @title_loan = TitleLoan.find(params[:id])
  end

  def update
    @title_loan = TitleLoan.find(params[:id])
    if @title_loan.update_attributes(params[:title_loan])
      flash[:notice] = "Successfully updated title loan."
      redirect_to title_loan_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @title_loan = TitleLoan.find(params[:id])
    @title_loan.destroy
    flash[:notice] = "Successfully destroyed title loan."
    redirect_to title_loans_url
  end
end
