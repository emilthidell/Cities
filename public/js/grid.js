
if(typeof app.grid == 'undefined'){
    app.grid = {};
}

app.grid.init = function(){
        $this = app.grid;

        $(".character").click(function(){
            var characterId = $(this).attr('id');
            $this.initWalking(characterId);
        });
};

app.grid.initWalking = function(characterId){
        $this = app.grid;
        console.log('open grid tools for ID '+characterId);

        var pathfinding = new EasyStar.js();
        var grid = [[0,0,1,0,0],
                    [0,0,1,0,0],
                    [0,0,1,0,0],
                    [0,0,1,0,0],
                    [0,0,0,0,0]];
        pathfinding.setGrid(grid);
        pathfinding.setAcceptableTiles([0]);
        pathfinding.findPath(0, 0, 4, 0, function( path ) {
        if (path === null) {
            alert("Path was not found.");
        } else {
            alert("Path was found. The first Point is " + path[0].x + " " + path[0].y);
        }
        pathfinding.setIterationsPerCalculation(1000);
        pathfinding.calculate();

    });
};

app.grid.init();
