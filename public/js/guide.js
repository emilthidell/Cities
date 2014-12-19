
if(typeof app.guide == 'undefined'){
    app.guide = {};
}
app.guide.appfreeSpaceHeight = 0;

app.guide.init = function(){

        $this = app.guide;

        if($('#your-guide').length > 0){
            $('#your-guide').fadeIn(400);
            $('#your-guide').animate({
                    'left': '200px',
                    'top' : (200+app.globals.appfreeSpaceHeight)+'px'
                },
                {
                    'easing':'easeInOutExpo',
                    'duration': 4000,
                    'complete': function(){

                        var guide = this;
                        var changer = 0;

                        function doBouncing(){
                          if(changer == 0){
                              changerValue = "+=15px";
                              changer = 1;
                          }else{
                              changerValue = "-=15px";
                              changer = 0;
                          }
                          $('#your-guide').animate({'top': changerValue, 'left': changerValue}, 2000);
                        }

                        doBouncing();
                        $this.initMessages();
                        setInterval(doBouncing, 2300);
                      }
                  }
            );
        }
};

app.guide.initMessages = function(){

    var parsedMessages = Array();
    var messages = $("#your-guide").attr('data');

    messages = JSON.parse(messages);

};

app.guide.decodeHtmlentitites = function(html) {
    var txt = document.createElement("textarea");
    txt.innerHTML = html;
    return txt.value;
}

app.guide.init();
