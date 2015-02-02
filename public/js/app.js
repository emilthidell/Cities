
if(typeof app == 'undefined'){
    var app = {};
}

app.init = function(){
    $this = app;
    $this.responsiveFrontPage();
    //$this.initWeather();
};

app.responsiveFrontPage = function(){
    $("window").ready(function(){

    });
};

app.initWeather = function(){
    $('.container').RainSnow({
        effect_name: 'rain',
        drop_appear_speed: 50,
        drop_falling_speed: 9000,
        wind_direction: 3,
        drop_rotate_angle : '-10deg',
        drop_count_width_height:[[2,10], [2,15], [2,20]],
        lighting_effect : [true, 50]
    });
}

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

app.init();
