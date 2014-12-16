<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Cities</title>
        <link href="//netdna.bootstrapcdn.com/bootswatch/2.3.1/united/bootstrap.min.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
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

              if($('.extra-home').length > 0){
                  $('.extra-home').click(function(){
                      var cityId = $(this).data('id');
                      window.location.href = '/cities/map/'+cityId;
                      return false;
                  });
                  var differ = 1;
                  setInterval(function(){
                      var homeBouncerTop = $('.extra-home').find('i').css('top').replace('px','');
                      if(homeBouncerTop > -10){
                          differ = -1;
                      }else if(homeBouncerTop < -15){
                          differ = 1;
                      }
                      $('.extra-home').find('i').css('top', (parseInt(differ)+parseInt(homeBouncerTop))+'px');
                  },100);
              }
            })
        </script>
    </body>
</html>
