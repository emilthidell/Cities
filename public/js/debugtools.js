
if(typeof app.debugtools == 'undefined'){
    app.debugtools = {};
}

app.debugtools.glassHidden = true;

app.debugtools.init = function(){
    $this = app.debugtools;
    console.log('Debug Tools init');
    $("a[href='#tileMode']").click(function(){
        if(app.debugtools.glassHidden){
            $('.glassTile').css('display','block');
            app.debugtools.glassHidden = false;
        }else{
            $('.glassTile').css('display','none');
            app.debugtools.glassHidden = true;
        }
    });
    var tld = $this.getDomainName();
    if(tld != 'dev'){
        window.console.log = function(output){
            //console.log('Not possible');
        }
    }
};

app.debugtools.getDomainName = function(){
    var tld = "";
    var tokens = document.domain.split('.');
    while(tokens.length){
        var token = tokens.pop();
        return token;
    }
    return null;
};

app.debugtools.init();
