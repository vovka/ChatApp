require 'active_support/inflector'
require 'active_record'

class ChatAction < Cramp::Websocket

  on_start :started
  on_data :received_data
  
  def received_data(data)
    puts "Hello, #{current_user.email}!"
    msg = "#{current_user.email}: #{data}"
    render msg
  end

  def started
    puts "\n\n\nstarted\n\n\n"
  end

  private

    def current_user
      return @current_user if @current_user
      session = @env['rack.session']
      klass, key = session['warden.user.user.key']
      klass = klass.constantize
      @current_user = klass.find_by_id key
    end
end
