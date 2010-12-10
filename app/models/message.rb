class Message < ActiveRecord::Base
  belongs_to :author, :foreign_key => :author_id, :primary_key => :id, :class_name => 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, :primary_key => :id, :class_name => 'User'
  alias_method :sender, :author

  def self.unread user
    user.messages.where(:read => false)
  end
end
