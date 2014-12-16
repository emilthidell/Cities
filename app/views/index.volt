<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Cities</title>
        <link href="//netdna.bootstrapcdn.com/bootswatch/2.3.1/united/bootstrap.min.css" rel="stylesheet">
        {{ stylesheet_link('css/style.css') }}
        {{ stylesheet_link('css/stoneage.css') }}
    </head>
    <body>
        <div class="navbar-spacer"></div>

        {{ content() }}

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script>
        <script>
            $(function () {
              $('[data-toggle="tooltip"]').tooltip()
              if($('.map').length > 0){
                 /*
                 * Adjust the Map position depending on the screen resolutions
                 */
                 var mapHeight = $( '.map' ).height();
                 var spacers   = parseInt($( '.navbar-spacer' ).height())+parseInt($( 'h2' ).height());

                 $( window ).resize(function() {

                     var winHeight = $( window ).height();

                     if(winHeight > parseInt(mapHeight)+parseInt(spacers)){
                         var availableHeight = parseInt(winHeight)-parseInt(spacers);
                         var freeSpace       = parseInt(availableHeight)-parseInt(mapHeight);

                         $('.map').css('top', (freeSpace/2)+'px');

                     }
                 });
                 $( window ).resize();
              }
            })
        </script>
    </body>
</html>
