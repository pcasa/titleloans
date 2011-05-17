class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  helper_method :current_company, :is_employed_at?
  before_filter :user_belongs_to_company
  
  
  def current_company
    if params[:company_id] != nil || params[:company_id] == 'companies'
      @current_company ||= Company.find(params[:company_id])
    else
      @current_company = nil
    end
    return @current_company
  end
  
  def is_employed_at?(user, company)
    employed = Employmentship.find_by_user_id_and_company_id(user.id, company.id)
    unless employed.blank?
      return true
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  protected

   def user_belongs_to_company
     unless !user_signed_in? || current_user.is?(:admin) || params[:company_id] == nil 
       if current_company.present? && !current_user.company_ids.include?(current_company.id)
         redirect_to root_url, :alert => "You don't belong there!"
       end
     end
   end

   def after_sign_in_path_for(resource_or_scope)
     if resource_or_scope.is_a?(User) 
       if resource_or_scope.is? :banned
          destroy_user_session_path
       else
        if resource_or_scope.companies.size == 1
          company_dashboard_path(resource_or_scope.companies.first)
        else
          root_url
        end
       end
     else
       super
     end
   end

end
