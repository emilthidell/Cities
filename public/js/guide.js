
if(typeof app.guide == 'undefined'){
    app.guide = {};
}

app.guide.appfreeSpaceHeight = 0;
app.guide.activeMessages     = [];

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
                        app.guide.initMessages();
                        setInterval(doBouncing, 2300);
                      }
                  }
            );
        }
};

app.guide.initMessages = function(){

    var parsedMessages = Array();
    var messages = $("#your-guide").attr('data');

    //messages = messages.replace("\\\\","\\");

    var firstChar = messages.charAt(0);
    var lastChar = messages.charAt(messages.length - 1);

    if(firstChar == "{" && lastChar == "}"){
        messages = messages.replace(',"2":',',');
        messages = "["+messages.slice(5, messages.length-1)+"]";
    }

    messages = JSON.parse(messages);

    for (i = 0; i < messages.length; i++) {
        if(i == 0){
            style = " style='display:block'";
        }
        if(messages[i].seconds == 0){
            messages[i].seconds = 10;
        }
        var guideMessage = '<div class="guideMessage" data-seconds="'+messages[i].seconds+'" style="display:none; width:'+messages[i].width+'px; height:'+messages[i].height+'px; left:'+messages[i].left+'px; top:'+messages[i].top+'px"><div class="bubble-pointer" style="left:'+messages[i].pointer_left+'px;"></div><i class="fa fa-'+messages[i].icon+'" style="line-height:'+messages[i].height+'px;"></i><div class="message">'+messages[i].message+'</div></div>';
        $("#your-guide").append(guideMessage);
    }
    var timeoutDelay = 0;
    $( ".guideMessage" ).each(function( index ) {
        var message = this;
        setTimeout(function(){
            $(message).fadeIn(500, function(){
                setTimeout(function(){
                    $(message).fadeOut(500, function(){
                        if(messages.length = index){
                            $("#your-guide").animate({'left': '-200px', 'top': '-100px' },{ 'duration': 1000, 'complete': function(){
                                $(this).remove();
                            }});
                        }
                    });
                }, ($(message).data('seconds')*1000));
            });
        }, timeoutDelay);

        timeoutDelay = parseInt(timeoutDelay)+(parseInt($(message).data('seconds'))*1000)+1000;

    });
};

app.guide.decodeHtmlentitites = function(html) {
    var txt = document.createElement("textarea");
    txt.innerHTML = html;
    return txt.value;
}

app.guide.init();
