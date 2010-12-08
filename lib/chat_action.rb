require 'active_support/inflector'
require 'active_record'
require 'devise'
#require 'devise_invitable'

module Rails
  def self.root
    "/home/vovka/development/ror/ChatApp"
  end

  def self.env
    "development"
  end
end

MODELS = ['user']

dbconfig = YAML::load(File.open(File.expand_path(File.join('config', 'database.yml'), Rails.root)))
ActiveRecord::Base.establish_connection(dbconfig['development'])
MODELS.each {|file| require File.expand_path(File.join('app', 'models', file), Rails.root) }

class ChatAction < Cramp::Websocket
  on_start :started
  on_data :received_data
  
  def received_data(data)
    msg = "Got your #{data}"
    #render msg
    #puts "self: #{self.inspect}"
    session = @env['rack.session']
    klass, key = session['warden.user.user.key']
    klass = klass.constantize
    user = klass.find_by_id key
    puts "Hello, #{user.username}!"
    #puts "@env['rack.session']['warden.user.user.key']: #{@env['rack.session']['warden.user.user.key']}"
  end

  def started
    puts "\n\n\nstarted\n\n\n"
  end
end
