# :nodoc:
class ApplicationController < ActionController::Base
  # before_filter :set_gettext_locale
  # before_action :authenticate_user!
  protect_from_forgery unless: -> { request.format.json? }
  # load_and_authorize_resource


  # before_action :logged_in_user, except: [:download]
  include ApplicationHelper
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404 #Redirect jika parsing data gak ketemu

  rescue_from CanCan::AccessDenied do |exception|
    # redirect_to root_url, alert: exception.message
    if logged_in?
      if current_user.role_id <= 13 or current_user.role_id == 19
        redirect_to root_path, alert: exception.message
        # else
        # redirect_to incoming_letters_url, alert: exception.message
      end
    else
      redirect_to login_url
    end
  end


  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def token_exist?
    unless token?
      # flash[:danger] = "Please log in."
      reset_session
      redirect_to login_url, alert: "akun anda salah"
    end
  end

  # You want to get exceptions in development, but not in production.
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: -> { render_404 }
  end
  rescue_from AbstractController::ActionNotFound, with: -> { render_404 }

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/error_404', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def custom_paginate_renderer
    # Return nice pagination for materialize
    Class.new(WillPaginate::ActionView::LinkRenderer) do
      def container_attributes
        {class: "pagination"}
      end

      def page_number(page)
        if page == current_page
          "<li class=\"cyan active\">"+link(page, page, rel: rel_value(page))+"</li>"
        else
          "<li class=\"waves-effect\">"+link(page, page, rel: rel_value(page))+"</li>"
        end
      end

      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(num, "<i class=\"material-icons\">Previous</i>")
      end

      def next_page
        num = @collection.current_page < total_pages && @collection.current_page + 1
        previous_or_next_page(num, "<i class=\"material-icons\">Next</i>")
      end

      def previous_or_next_page(page, text)
        if page
          "<li class=\"waves-effect\">"+link(text, page)+"</li>"
        end
      end
    end
  end
end
