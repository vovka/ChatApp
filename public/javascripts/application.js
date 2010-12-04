if (!window.console){
  window.console = {};
  window.console.log = function(){}
}

$(document).ready(function(){

  var communicator = new Communicator(
    $('textarea[name="chatin"]')[0], $('div.chat div:first-child')[0], 
    window.ws_domain, window.ws_port, window.ws_path);

  $('textarea[name="chatin"]').keypress(function(e){
    if(
      e.which == 10 || //for my chrome
      (e.which == 13 && e.ctrlKey)
    ){
      communicator.chat();
    }
  });

});

