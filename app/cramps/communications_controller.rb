class CommunicationsController < Cramp::Controller::Websocket
  periodic_timer :send_hello_world, :every => 2
  on_data :received_data
 
  def received_data(data)
    if data =~ /stop/
      render "You stopped the process"
      finish
    else
      render "Got your #{data}"
    end
  end
 
  def send_hello_world
    render "Hello from the Server!"
  end
end
