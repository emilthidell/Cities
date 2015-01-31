
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
};

app.debugtools.init();
