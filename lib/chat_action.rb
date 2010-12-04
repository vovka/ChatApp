class ChatAction < Cramp::Websocket
  on_data :received_data
  
  def received_data(data)
    msg = "Got your #{data}"
    render msg
  end
end
