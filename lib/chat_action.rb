require 'active_support/inflector'
require 'active_record'

class ChatAction < Cramp::Websocket

  on_start :started
  on_data :received_data
  periodic_timer :pull_chat_messages, :every => 1
  
  def received_data data
    if signed_in?
      recipient = not_me
      msg = Message.create :author_id => current_user.id, :recipient_id => recipient.id,
        :body => data, :read => false
      render formatted(msg)
    end
  end

  def started
    puts "\n\n\nstarted\n\n\n"
  end

  private

    def current_user
      return @current_user if @current_user
      session = @env['rack.session']
      klass, key = session['warden.user.user.key']
      unless klass.nil?
        klass = klass.constantize
        @current_user = klass.find_by_id key
      else
      end
    end

    def signed_in?
      not current_user.nil?
    end

    def pull_chat_messages
      if signed_in?
        messages = Message.unread(current_user)
        if messages.any?
          messages.each do |m|
            render formatted(m)
            m.update_attribute :read, true
          end
        end
      end
    end

    def formatted message
      "<strong>#{message.author.email}:</strong>&nbsp;#{message.body}"
    end

    def not_me
      @not_me ||= User.where(["NOT id = ?", current_user.id]).first
    end
end
