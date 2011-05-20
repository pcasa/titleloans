class TitleDocsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  
  before_filter :find_title
  before_filter :find_or_build_title_doc
  
  def create
    respond_to do |format|
      unless @title_doc.save
        flash[:error] = 'TitleDoc could not be uploaded'
      end
      format.js 
    end
  end

  def destroy
    respond_to do |format|
      unless @title_doc.destroy
        flash[:error] = 'TitleDoc could not be deleted'
      end
      format.js
    end
  end

  private
    
    def find_title
      @title_loan = TitleLoan.find(params[:title_loan_id])
      raise ActiveRecord::RecordNotFound unless @title_loan
    end
    
    def find_or_build_title_doc
      @title_doc = params[:id] ? @title_loan.title_docs.find(params[:id]) : @title_loan.title_docs.build(params[:title_doc])
    end

end