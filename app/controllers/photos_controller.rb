class PhotosController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  
  before_filter :find_title
  before_filter :find_or_build_photo
  
  def create
    respond_to do |format|
      unless @photo.save
        flash[:error] = 'Photo could not be uploaded'
      end
      format.js do
        render :text => render_to_string(:partial => 'photos/photo', :locals => {:photo => @photo})
      end
    end
  end

  def destroy
    respond_to do |format|
      unless @photo.destroy
        flash[:error] = 'Photo could not be deleted'
      end
      format.js
    end
  end

  private
    
    def find_title
      @title_loan = TitleLoan.find(params[:title_loan_id])
      raise ActiveRecord::RecordNotFound unless @title_loan
    end
    
    def find_or_build_photo
      @photo = params[:id] ? @title_loan.photos.find(params[:id]) : @title_loan.photos.build(params[:photo])
    end

end