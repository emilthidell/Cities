
if(typeof app == 'undefined'){
    var app = {};
}

app.init = function(){
    $this = app;
    $this.responsiveFrontPage();
};

app.responsiveFrontPage = function(){
    $("window").ready(function(){

    });
};

app.replaceTags = function(string, tags) {
    var fields = string.match(/[^{}]+(?=\})/g);
    console.log(fields);
}

app.message = function(message, error){

    if(error){
        return app.message.error(message);
    }
    return app.message.error(message);
};

app.message.error = function(){

    return true;
};

app.message.error = function(){

    return true;
};

app.init();
