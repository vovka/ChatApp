require 'active_support/inflector'
require 'active_record'

class ChatAction < Cramp::Websocket
  include AbstractController::Helpers
  #include Devise::Controllers::Helpers

  on_start :started
  on_data :received_data
  
  def received_data(data)
    msg = "Got your #{data}"
    #render msg
    session = @env['rack.session']
    klass, key = session['warden.user.user.key']
    klass = klass.constantize
    user = klass.find_by_id key
    #puts "current_user: #{current_user.inspect}"
    puts "Hello, #{user.email}!"
  end

  def started
    puts "\n\n\nstarted\n\n\n"
  end
end
