
if(typeof app.positions == 'undefined'){
    app.positions = {};
}

app.positions.init = function(){
    $this = app.positions;

    var CharacterSaver = setInterval(function(){
        app.positions.saveCharacters();
    },2000);

    var BuildingSaver = setInterval(function(){
        app.positions.saveBuildings();
    },5000);
};

app.positions.saveCharacters = function(){
    $this = app.positions;

    console.log('save Chars');
};

app.positions.saveBuildings = function(){
    $this = app.positions;

    console.log('save Buildings');
};

app.positions.init();
