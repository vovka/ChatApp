class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_flash_types
  
  def set_flash_types
    @flash_types = [:alert, :notice]
  end
end
