function Communicator(){
  this.init(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4]);
}

Communicator.prototype = {
  init : function(text_source, text_out, ws_domain, ws_port, ws_path){
    this.ws = this._create_ws(ws_domain, ws_port, ws_path);
    this.text_source = text_source;
    Communicator.prototype.text_out = text_out;
  },

  chat : function(){
    this.ws.send(this.text_source.value);
    this.text_source.value = '';
  }, 
  
  _create_ws : function(ws_domain, ws_port, ws_path){
    var ws = new WebSocket('ws://' + ws_domain + ':' + ws_port + '/' + ws_path);
    for (var i in this._event_handlers){
      eval('ws.'+i+'=this._event_handlers.'+i);
    }
    return ws;
  },
  
  _event_handlers : {
    onopen : function(e){},
    onmessage : function(e){
      var msg = document.createElement('p');
      msg.innerHTML = e.data;
      Communicator.prototype.text_out.appendChild(msg);
    }
  }
}
